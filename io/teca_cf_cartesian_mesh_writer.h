#ifndef teca_cf_cartesian_mesh_writer_h
#define teca_cf_cartesian_mesh_writer_h

#include "teca_shared_object.h"
#include "teca_algorithm.h"
#include "teca_metadata.h"

#include <vector>
#include <string>

TECA_SHARED_OBJECT_FORWARD_DECL(teca_cf_cartesian_mesh_writer)

/**
an algorithm that writes cartesian meshes in NetCDF CF format.
*/
class teca_cf_cartesian_mesh_writer : public teca_algorithm
{
public:
    TECA_ALGORITHM_STATIC_NEW(teca_cf_cartesian_mesh_writer)
    ~teca_cf_cartesian_mesh_writer();

    // report/initialize to/from Boost program options
    // objects.
    TECA_GET_ALGORITHM_PROPERTIES_DESCRIPTION()
    TECA_SET_ALGORITHM_PROPERTIES()

    // set the output filename. for time series the substring
    // %t% is replaced with the current time step.
    TECA_ALGORITHM_PROPERTY(std::string, file_name)

    // control how many time steps are written to each file
    TECA_ALGORITHM_PROPERTY(unsigned int, steps_per_file)

protected:
    teca_cf_cartesian_mesh_writer();

private:
    const_p_teca_dataset execute(unsigned int port,
        const std::vector<const_p_teca_dataset> &input_data,
        const teca_metadata &request) override;

    teca_metadata get_output_metadata(unsigned int port,
        const std::vector<teca_metadata> &input_md) override;

    std::vector<teca_metadata> get_upstream_request(unsigned int port,
        const std::vector<teca_metadata> &input_md,
        const teca_metadata &request) override;
private:
    std::string file_name;
    unsigned int steps_per_file;
};

#endif
