HTMLWidgets.widget({

  name: 'jview',

  type: 'output',

  factory: function(el, width, height) {

    return {

      renderValue: function(x) {

        // remove element children if element exists
        if (document.getElementById(el.id) !== null) {
          while (el.firstChild) {
            el.removeChild(el.firstChild);
          }
        }

        const tree = JsonView.createTree(x.data);
        JsonView.render(tree, document.querySelector("#" + el.id));

        if (x.expanded) {
          JsonView.expandChildren(tree);
        }

      },

      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
      }

    };
  }
});
