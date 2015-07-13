#
# Intact Case for Ruby
# Interconverting camelCase and snake_case which include acronym.
#
# @author StewEucen
# @copyright Copyright (c) 2015 Stew Eucen (http://lab.kochlein.com)
# @license   http://www.opensource.org/licenses/mit-license.php  MIT License
#
# @link       http://lab.kochlein.com/IntactCase
# @since      File available since Release 1.0.0
# @version    1.0.0
#
module StewEucen
  # Name space of Stew Eucen's Acts
  module Acts
    # Name space of Intact Case
    module IntactCase

      #
      # Methods to include into String class.
      #
      # @author StewEucen
      # @example Include into String class.
      #   String.send :include, StewEucen::Acts::IntactCase::String
      # @since  Release 1.0.0
      #
      module String

        #
        # Convert compound words to camelCase from delimiterized.
        #
        # @author StewEucen
        # @example delimiterized to camelCase.
        #   'snake_case'.camelize         #=> 'snakeCase'
        #   'get_utc__day'.camelize       #=> 'getUTCDay'
        #   'ui__view'.camelize           #=> 'ui_View'
        #   'xml__html__request'.camelize #=> 'xml_HTMLRequest'
        # @param  [string] delimiter Delimiter.
        # @return [string] camelCase String.
        # @since  Release 1.0.0
        #
        def camelize(delimiter = '_')
          d = Regexp.escape(delimiter)

          camel_head    = "^([a-z]{2,}#{d})(?:#{d}|$)"  # can not use (?![a-z]) because (?:)
          capitalize    = "(?<=#{d})([a-z])"
          rear_acronym  = "(?!^)([a-z]+)#{d}(?![a-z])"
          cut_delimiter = "(?<=^|[a-z]{2})#{d}|#{d}(?=[a-z]{2,}(?:#{d}[a-z]|$))"

          cases_pattern = /#{camel_head}|#{capitalize}|#{rear_acronym}|#{cut_delimiter}/
          self.gsub(cases_pattern) { "#{$1}" + "#{$2}#{$3}".upcase }
        end

        #
        # Convert compound words to StudlyCaps from delimiterized string.
        #
        # @author StewEucen
        # @example delimiterized to StudlyCaps.
        #   'snake_case'.studly_caps         #=> 'SnakeCase'
        #   'get_utc__day'.studly_caps       #=> 'GetUTCDay'
        #   'ui__view'.studly_caps           #=> 'UIView'
        #   'xml__html__request'.studly_caps #=> 'XML_HTMLRequest'
        # @param  [string] delimiter Delimiter.
        # @return [string] StudlyCaps string.
        # @since  Release 1.0.0
        #
        def studly_caps(delimiter = '_')
          ((self.start_with?(delimiter) ? '' : delimiter) + self).camel_case(delimiter)
        end

        #
        # Convert compound words connected by a delimiter from camelCase|StudlyCaps.
        #
        # @author StewEucen
        # @example camelCase|StudlyCaps to delimiterized.
        #   'camelCase'.delimiterize             #=> 'camel_case'
        #   'StudlyCaps'.delimiterize('_', true) #=> '_studly_caps'
        #   'chainCase'.delimiterize('-')        #=> 'chain-case'
        #   'getUTCDay'.delimiterize             #=> 'get_utc__day'
        #   'UIView'.delimiterize                #=> 'ui__view'
        #   'XML_HTMLRequest'.delimiterize       #=> 'xml__html__request'
        # @param  [string] delimiter Concatenate tokens with between delimiter.
        # @param  [boolean] as_vendor_prefix Treat as vendor-prefix (CSS).
        # @return [string] Delimiterized compound words.
        # @since  Release 1.0.0
        #
        def delimiterize(delimiter = '_', as_vendor_prefix = false)
          d = Regexp.escape(delimiter)

          before_acronym = "(?:^[a-z]{2,}#{d}|[a-z])(?=[A-Z](?![a-z]))"
          after_acronym  = "[A-Z]{2,}(?![a-z])"
          before_capital = "(?!^)(?=[A-Z][a-z])"
          p = /#{before_acronym}|#{after_acronym}|#{before_capital}/;

          head_delimiter = as_vendor_prefix && /^[A-Z]/ =~ self ? delimiter : ''
          head_delimiter + self.gsub(p) { $& + delimiter }.downcase
        end

        #
        # Hyphenate compound words from camelCase|StudlyCaps.
        #
        # @author StewEucen
        # @example camelCase|StudlyCaps to hyphenated string.
        #   'chainCase'.hyphenated          #=> 'chain-case'
        #   'VendorPrefix'.hyphenated(true) #=> '-vendor-prefix'
        #   'camelCase'.hyphenated(true)    #=> 'camel-case'
        # @param  [boolean] as_vendor_prefix Treat as vendor-prefix (CSS).
        # @return [string] Hyphenated string.
        # @since  Release 1.0.0
        #
        def hyphenated(as_vendor_prefix = false)
          self.delimiterize('-', as_vendor_prefix)
        end

        #
        # Explode compound words to tokens.
        #
        # @author StewEucen
        # @example Tokens from compound words.
        #   'camelCase'.tokenize            #=> ['Camel', 'Case']
        #   'camelCase'.tokenize('_', true) #=> ['camel', 'Case']
        #   'StudlyCaps'.tokenize           #=> ['Studly', 'Caps']
        #   'snake_case'.tokenize           #=> ['snake', 'case']
        #   'get_utc__day'.tokenize         #=> ['get', 'utc_', 'day']
        # @param  [string] delimiter Delimiter.
        # @param  [boolean] raw_first Keep raw first word in tokens for camelCase.
        # @return [array] Tokens except delimiter between acronym.
        # @see    _tokenize_from_camelized, _tokenize_from_delimiterized
        # @since  Release 1.0.0
        #
        def tokenize(delimiter = '_', raw_first = false)
          if /[A-Z]/ =~ self then
            _tokenize_from_camelized(delimiter, raw_first)
          else
            _tokenize_from_delimiterized(delimiter)
          end
        end

        private

          #
          # Tokenize compound words from camelCase|StudlyCaps.
          #
          # @author StewEucen
          # @param  [string] delimiter Delimiter between acronym.
          # @param  [boolean] raw_first Keep raw first word in tokens for camelCase.
          # @return [array] Tokens except delimiter between acronym.
          # @since  Release 1.0.0
          #
          def _tokenize_from_camelized(delimiter, raw_first)
            d = Regexp.escape(delimiter)
            p = /(?:[A-Z]+|[A-Z]?(?:[a-z]{2,}#{d}?|[a-z]))(?![a-z])/;
            # (?:                              : token body
            #   [A-Z]+                         : acronym
            #   |                              : or
            #   [A-Z]?(?:[a-z]{2,}#{d}?|[a-z]) : usual word|first in camelCase|
            # )
            # (?![a-z])                        : break word same as (?=[A-Z]|_|$)
            tokens = self.scan(p)

            # Upcase for acronym of first word in camelCase.
            tokens[0] = tokens[0].studly_caps(delimiter) unless raw_first

            tokens
          end

          #
          # Tokenize compound words from delimiterized.
          #
          # @author StewEucen
          # @param  [string] delimiter Delimiter.
          # @return [array] Tokens except delimiter between acronym.
          # @since  Release 1.0.0
          #
          def _tokenize_from_delimiterized(delimiter)
            d = Regexp.escape(delimiter)
            p = /[a-z]+#{d}?(?![a-z])/

            self.scan(p).compact
          end

        public

        #
        # Capitalize first word in compound words.
        # When first word is acronym, convert it to StudlyCaps.
        #
        # @author StewEucen
        # @example StudlyCaps from camelCase
        #   'camelCase'.uc_first       #=> 'CamelCase'
        #   'xml_HTMLRequest'.uc_first #=> 'XML_HTMLRequest'
        # @param  [string] delimiter Delimiter after acronym.
        # @return [string] StudlyCaps (= capitalized camelCase).
        # @since  Release 1.0.0
        #
        def uc_first(delimiter = '_')
          self.delimiterize(delimiter).studly_caps(delimiter)
        end

        #
        # Uncapitalize first word in compound words.
        # When first word is acronym, convert it to delimiterized string.
        #
        # @author StewEucen
        # @example camelCase from StudlyCaps
        #   'StudlyCaps'.lc_first #=> 'studlyCaps'
        #   'UIView'.lc_first     #=> 'ui_View'
        # @param  [string] delimiter Delimiter after acronym.
        # @return [string] camelCase (= uncapitalized StudlyCaps).
        # @since  Release 1.0.0
        #
        def lc_first(delimiter = '_')
          self.delimiterize(delimiter).camelize(delimiter)
        end

        #
        # a.k.a.
        #
        alias_infos = {
              camelize: [:nerd_caps, :camel_case],
           studly_caps: [:pascal_case],
          delimiterize: [:snake_case, :underscored],
            hyphenated: [:train_case, :chain_case, :kebab_case, :spinal_case],
        }

        alias_infos.each_pair do |origin_name, alias_names|
          alias_names.each { |alias_name| alias_method alias_name, origin_name }
        end
      end

      #
      # Methods to include into Array class.
      #
      # @author StewEucen
      # @example Include into String class.
      #   Array.send :include, StewEucen::Acts::IntactCase::Array
      # @since  Release 1.0.0
      #
      module Array

        #
        # Concatenate tokens (camelCase/StudlyCaps/snake_case).
        #
        # @author StewEucen
        # @example tokens from snake_case
        #   ['camel', 'Case'].compound           #=> 'camelCase'
        #   ['Studly', 'Caps'].compound          #=> 'StudlyCaps'
        #   ['XML', 'HTML', 'Request'].compound  #=> 'XML_HTMLRequest'
        #   ['get', 'utc_', 'day'].compound      #=> 'get_utc__day'
        #   ['', 'webkit', 'flex'].compound('-') #=> '-webkit-flex'
        # @param  [string] delimiter Delimiter between acronym.
        # @return [string] camelCase/StudlyCaps/snake_case.
        # @since  Release 1.0.0
        #
        def compound(delimiter = '_')
          compounded = self.join(delimiter)
          # When snake_case.
          return compounded if /[A-Z]/ !~ compounded

          d = Regexp.escape(delimiter)
          p = /(?<=.[a-z])#{d}|(?<!#{d})#{d}(?=[A-Z][a-z])/
          compounded.gsub(p, '')
        end
      end

    end
  end
end
