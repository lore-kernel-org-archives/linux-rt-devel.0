Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F43C381E91;
	Thu,  6 Aug 2026 04:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785990585; cv=none; b=oX1C9q3hkUQsTm7WEPqRC21iu1pzX+1BO4ej+fMVfvdyNz8oedmpaj9/szODmIjKhe+G7CgMhaNqZ+QzVHVbUgZcY5OLDKYplCbCucVwi6piYbbXtx+5jaYHxgPULk3MfMml6Gz4NmCmvOmBSL8pD7wdGpwTBZPmqvm+7ONtOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785990585; c=relaxed/simple;
	bh=7CW8Mojz4tTHJtxhvNY+//zqS7ohbSQ0PPY1CWQ9nuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZyqWGuGZlUfgX9i29RgiSIB1psghta34rY74nkgcw0XjEsaaQhvKIQKv20RxUD3r73W1W9ZofALRXs8OMkTFApATHwO74IxfV8XJiKjYks0HzP2E2yVyrnFrJBDXOZqf3aVmQzDE5+/ilcRHTXF9VFA1qCH/e5Po0Up8Sxszn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eU2U0F9G; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eU2U0F9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785990582; x=1817526582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7CW8Mojz4tTHJtxhvNY+//zqS7ohbSQ0PPY1CWQ9nuM=;
  b=eU2U0F9GJYZY8d8wEFlkC/8UqNst6f/8uJ8NO2A2cj2awtdv0lW5Fii2
   y/aITJaTQ1emYWn0ZYg7is+S3gl6J+voBu2Cbsa2T20zv0iaAIk10KSW+
   4aRaU52SrH10+ynVrmKLOklQ46AMD0p8i5p49O9qwzFZ8ZhmNZNrsumPO
   Mf4sxxmHb/aKcd5ZDK9KrPIPJD3eETRWnxw4fL6WEpN4xyY0LLGEnIFHy
   Im5Lj5EX5nU/EZmhjtfWo7NFKIY9vaheKeCEW1Y1Uc6LG9+RVKbcQjxo5
   3KwnNle2+q629LXL0ZQUQMsd615emfJNlz/OhcTm4pfNWjd5OrPb1OZlM
   Q==;
X-CSE-ConnectionGUID: I3MJhHhRSzeT+/wtxIvdxw==
X-CSE-MsgGUID: m5aBEMBxQ5qiv6RnB+jLHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="85700024"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="85700024"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 21:29:42 -0700
X-CSE-ConnectionGUID: mLQTR0OkQ/2wCOMWalBDJQ==
X-CSE-MsgGUID: rBVBeQQARBiEmx1VFZ4j5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="257693647"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Aug 2026 21:29:39 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrpjc-00000000E8v-0vnM;
	Thu, 06 Aug 2026 04:29:36 +0000
Date: Thu, 6 Aug 2026 12:29:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	"# = v7 . 1" <stable@vger.kernel.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rafal Ostrowski <rafal.ostrowski@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with
 PREEMPT_RT
Message-ID: <202608061233.eufnR5Qm-lkp@intel.com>
References: <20260801071724.12998-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801071724.12998-1-spasswolf@web.de>

Hi Bert,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20260804]
[cannot apply to drm-misc/drm-misc-next linus/master v7.2-rc6 v7.2-rc5 v7.2-rc4 v7.2-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bert-Karwatzki/drm-amd-display-fix-usage-of-DC_FPU_-BEGIN-END-with-PREEMPT_RT/20260805-170330
base:   next-20260804
patch link:    https://lore.kernel.org/r/20260801071724.12998-1-spasswolf%40web.de
patch subject: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260806/202608061233.eufnR5Qm-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260806/202608061233.eufnR5Qm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608061233.eufnR5Qm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.c: In function 'dc_create_plane_state':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.c:89:9: error: implicit declaration of function 'DC_RUN_WITH_PREEMPTION_ENABLED' [-Wimplicit-function-declaration]
      89 |         DC_RUN_WITH_PREEMPTION_ENABLED(plane_state = kvzalloc_obj(*plane_state, GFP_ATOMIC));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/DC_RUN_WITH_PREEMPTION_ENABLED +89 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.c

    82	
    83	/*******************************************************************************
    84	 * Public functions
    85	 ******************************************************************************/
    86	struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
    87	{
    88		struct dc_plane_state *plane_state;
  > 89		DC_RUN_WITH_PREEMPTION_ENABLED(plane_state = kvzalloc_obj(*plane_state, GFP_ATOMIC));
    90	
    91		if (NULL == plane_state)
    92			return NULL;
    93	
    94		kref_init(&plane_state->refcount);
    95		dc_plane_construct(dc->ctx, plane_state);
    96	
    97		return plane_state;
    98	}
    99	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
