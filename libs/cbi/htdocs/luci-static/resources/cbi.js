var cbi_d = [];

function cbi_d_add(field, dep) {	
	var obj = document.getElementById(field);
	if (obj) {
		var entry
		for (var i=0; i<cbi_d.length; i++) {
			if (cbi_d[i].id == field) {
				entry = cbi_d[i];
				break;
			}
		}
		if (!entry) {
			entry = {
				"id": field,
				"node": obj,
				"parent": obj.parentNode,
				"next": obj.nextSibling,
				"deps": []
			};
			cbi_d.unshift(entry);
		}	
		entry.deps.push(dep)
	}
}

function cbi_d_value(target) {
	var t = document.getElementById(target);
	var value
	
	if (!t || !t.value) {
		value = "";
	} else {
		value = t.value;
		
		if (t.type == "checkbox") {
			value = t.checked ? value : "";
		}
	}
	
	return value
}

function cbi_d_check(deps) {
	for (var i=0; i<deps.length; i++) {
		var istat = true
		for (var j in deps[i]) {
			istat = (istat && cbi_d_value(j) == deps[i][j])
		}
		if (istat) {
			return true
		}
	}		
}

function cbi_d_update() {
	var state = false;
	for (var i=0; i<cbi_d.length; i++) {
		var entry = cbi_d[i];
		if (entry.node.parentNode && !cbi_d_check(entry.deps)) {
			entry.parent.removeChild(entry.node);
			state = (state || !entry.node.parentNode)
		} else if (!entry.node.parentNode && cbi_d_check(entry.deps)) {
			if (!entry.next) {
				entry.parent.appendChild(entry.node);
			} else {
				entry.parent.insertBefore(entry.node, entry.next);
			}		
			state = (state || entry.node.parentNode)
		}
	}
	if (state) {
		cbi_d_update();
	}
}

function cbi_bind(obj, type, callback, mode) {
	if (typeof mode == "undefined") {
		mode = false;
	}
	if (!obj.addEventListener) {
		ieCallback = function(){
			var e = window.event;
			if (!e.target && e.srcElement) {
				e.target = e.srcElement;
			};
			e.target['_eCB' + type + callback] = callback;
			e.target['_eCB' + type + callback](e);
			e.target['_eCB' + type + callback] = null;
		};
		obj.attachEvent('on' + type, ieCallback);
	} else {
		obj.addEventListener(type, callback, mode);
	}
	return obj;
}

function cbi_combobox(id, values, def, man) {
	var obj = document.getElementById(id)
	var sel = document.createElement("select");
	obj.parentNode.appendChild(sel);

	if (!values[obj.value]) {
		if (obj.value == "") {
			var optdef = document.createElement("option");
			optdef.value = "";
			optdef.appendChild(document.createTextNode(def));
			sel.appendChild(optdef);
		} else {
			var opt = document.createElement("option");
			opt.value = obj.value;
			opt.selected = "selected";
			opt.appendChild(document.createTextNode(obj.value));
			sel.appendChild(opt);
		}
	}

	for (var i in values) {
		var opt = document.createElement("option");
		opt.value = i;

		if (obj.value == i) {
			opt.selected = "selected";
		}

		opt.appendChild(document.createTextNode(values[i]));
		sel.appendChild(opt);
	}

	var optman = document.createElement("option");
	optman.value = "";
	optman.appendChild(document.createTextNode(man));
	sel.appendChild(optman);

	obj.style.display = "none";

	cbi_bind(sel, "change", function() {
		if (sel.selectedIndex == sel.options.length - 1) {
			obj.style.display = "inline";
			sel.parentNode.removeChild(sel);
			obj.focus();
		} else {
			obj.value = sel.options[sel.selectedIndex].value;
		}
	})
}

function cbi_combobox_init(id, values, def, man) {
	var obj = document.getElementById(id);
	cbi_bind(obj, "blur", function() {
		cbi_combobox(id, values, def, man)
	});
	cbi_combobox(id, values, def, man);
}