Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9016C1FF7C8;
	Sat,  3 Oct 2026 02:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995102; cv=none; b=eoYtPhM68zVXAQYNpJO3lHX+UHZEod/RQYAHlfygXFHvnUuDnrYcaMOYzyMBIx7878pltG3nvg1ACi1i9uOgg3FQMul1oAIS67coC2CtwQKF7JSP8xk6QaqmyoEksDwMfHVCAb17TNWjcW51xAVREl9JNoaYedz3O5yXdSCcTX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995102; c=relaxed/simple;
	bh=GDefS7MkG1d9C4DwbYgXKcH36tQiGnM2EUlFCk0a39A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nw9mor/RMZq92aL8tfZ4gMPdzjpc1DroWWvKTCJHf3rnWu0/t/WPp2u7UJ5k8fyQNl2yJ8Th4jXdELF7GaEcKkJcFin497+wgaaS3fCfGNnUCEpTBeTIGFxFlavN44fY3PXz76Me1l1lAqY2jTquOWmfYpJkl258vMNCRwjAkL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=C68i8VrI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="C68i8VrI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82B7F2F;
	Fri,  2 Oct 2026 19:38:16 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1928F3F763;
	Fri,  2 Oct 2026 19:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790995099; bh=GDefS7MkG1d9C4DwbYgXKcH36tQiGnM2EUlFCk0a39A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C68i8VrI7OrYN/3uKLZqbVhhH+ul6IeOKMAYCToY/AqjV4HFlZ5KgDitQo/+J85wP
	 FyWF/b0OJKGhO97ivcLfOkGqqbFzCRmg6U7wBaf4YwQugfccDko9XDFCi7kkg0kHO5
	 UuiPccjhR3g939aBoWZHVosQ4foVMQtQXPcMwueE=
Date: Sat, 3 Oct 2026 03:38:16 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v13 08/14] coresight: etm4x: exclude ss_status from
 drvdata->config
Message-ID: <asBqmNH3ybK7jhsX@e129823.arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
 <20261002-separate_etm_cfg_v2-v13-8-fe429d8d96fb@arm.com>
 <20261003013344.22BF71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261003013344.22BF71F00893@smtp.kernel.org>

On Sat, Oct 03, 2026 at 01:33:43AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] coresight: etm4x: state leakage of single-shot comparator status in perf sessions
> --
> 
> commit 3d98ebedda262d5221467f55a32e0267bdd2e584
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> coresight: etm4x: exclude ss_status from drvdata->config
> 
> This patch moves the single-shot comparator status (ss_status) from the
> configuration structure to the driver data structure. It updates the usage
> of ss_status to clear both TRCSSCSRn_STATUS and TRCSSCSRn_PENDING bits
> before writing to the register.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index 3900b96e9c7cc..4a8c1070bbcbb 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> 
> [ ... ]
> 
> > @@ -572,11 +572,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
> >  		etm4x_relaxed_write32(csa, config->res_ctrl[i], TRCRSCTLRn(i));
> >  
> >  	for (i = 0; i < caps->nr_ss_cmp; i++) {
> > -		/* always clear status bit on restart if using single-shot */
> > +		/* always clear status and pending bits on restart if using single-shot */
> >  		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
> > -			config->ss_status[i] &= ~TRCSSCSRn_STATUS;
> 
> [Severity: Medium]
> Will this bypass the manual clearing of the TRCSSCSRn_STATUS and
> TRCSSCSRn_PENDING bits during perf sessions?
> 
> Since enabling a perf session uses a zeroed configuration, config->ss_ctrl[i]
> and config->ss_pe_cmp[i] will evaluate to false. Previously, this wasn't an
> issue because the entire config structure was zeroed via memset. Now that
> ss_status is moved to drvdata, bypassing this check means the bits are not
> cleared.
> 
> > +			drvdata->ss_status[i] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
> >  		etm4x_relaxed_write32(csa, config->ss_ctrl[i], TRCSSCCRn(i));
> > -		etm4x_relaxed_write32(csa, config->ss_status[i], TRCSSCSRn(i));
> > +		etm4x_relaxed_write32(csa, drvdata->ss_status[i], TRCSSCSRn(i));
> 
> Does this write a stale, unmasked drvdata->ss_status[i] directly to the
> TRCSSCSRn hardware register during perf sessions?
> 
> If the manual clearing above is skipped, this could cause state leakage and
> trigger unintended hardware trace behavior.
> 
> >  		if (etm4x_sspcicrn_present(drvdata, i))
> >  			etm4x_relaxed_write32(csa, config->ss_pe_cmp[i], TRCSSPCICRn(i));
> >  	}

No. Since curr_config is initialized to zero and the other bits in ss_status
are RO or RES fields, clearing only the STATUS and PENDING bits has the same
effect as zeroing the entire value.


> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com?part=8

-- 
Sincerely,
Yeoreum Yun
