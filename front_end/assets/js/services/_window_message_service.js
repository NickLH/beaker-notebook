;(function(app) {
  app.service('WindowMessageService', ['$window', '$location', 'Factories', function($window, $location, Factories) {

    var F = Factories;
    var saveNotebookCallbacks = {};

    function saveNotebook(data) {
      var saveFunction = data.operation == 'create' ?
        F.Notebooks.createNotebook : F.Notebooks.updateNotebook;
      saveFunction(data.projectId, data.notebook).
        then(function() {
          var callbacks = saveNotebookCallbacks[data.projectId] || []
          _.each(callbacks, function(cb) { cb(); });
        }, function(response) {
          $window.alert("Error attempting to " + data.operation + " notebook.");
        });
    };

    function receiveWindowMessage(e) {
      if (new URL(event.origin).hostname !== $location.host()) {
        throw "message received from unauthorized host " + event.origin.host;
      }
      if (!e.data.notebook) return; // could be a message for a different purpose
      saveNotebook(e.data);
    }

    $window.addEventListener('message', receiveWindowMessage, false);

    return {
      addNotebookCallback: function(projectId, cb) {
        saveNotebookCallbacks[projectId] = saveNotebookCallbacks[projectId] || [];
        saveNotebookCallbacks[projectId].push(cb);
      }
    };
  }]);
})(window.bunsen);