#!/usr/bin/env ruby

$:.unshift '../lib' if __FILE__ == $0 # Make this library first!

require 'test/unit'

require 'nagios'

class TestBase < Test::Unit::TestCase
    # Verify that our params are available as attributes.
    def test_attributes
        host = nil
        assert_nothing_raised {
            host = Nagios::Base.create(:host)
        }

        assert_nothing_raised {
            host.notifications_enabled = true
        }

        assert(host.respond_to?(:notifications_enabled),
            "Did not define method")

        assert_raise(NoMethodError) do
            host.nosuchattribute = false
        end
    end

    # Make sure every type has a namevar.
    def test_attributes
        Nagios::Base.eachtype do |name, type|
            assert_nothing_raised {
                assert(type.name, "Type %s did not return a name" % type)
            }

            assert_equal(name, type.name, "Type %s had a messed up name" % type)

            assert_nothing_raised {
                assert(type.namevar, "Type %s did not return a namevar" % type)
            }

            assert_nothing_raised {
                assert(type.parameters, "Type %s did not return parameters" % type)
            }
        end
    end
end

# $Id$