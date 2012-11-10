###
# ownCloud - News app
#
# @author Bernhard Posselt
# Copyright (c) 2012 - Bernhard Posselt <nukeawhale@gmail.com>
#
# This file is licensed under the Affero General Public License version 3 or later.
# See the COPYING-README file
#
###

angular.module('News').factory 'Persistence', () ->

	class Persistence

		constructor: (@appName, @$http) ->


		post: (file, data={}, callback) ->
			if not callback
				callback = ->

			url = OC.filePath(@appName, 'ajax', file + '.php')

			data = $.param(data)

			# csrf token
			headers =
				requesttoken: oc_requesttoken
				'Content-Type': 'application/x-www-form-urlencoded'
			
			@$http.post(url, data, {headers: headers}).
			success((data, status, headers, config) ->
				if data.status == "error"
					alert data.data.message
				else
					callback(data)
			).
			error (data, status, headers, config) ->
				console.warn('Error occured: ')
				console.warn(status)
				console.warn(headers)
				console.warn(config)
