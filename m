Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55B43E07E;
	Fri, 11 Sep 2026 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126949; cv=none; b=mynvKfJMG4J2XnMoihEibUv7UPYDgkLTvZnnlYKFstmnTI6KpEaVxhSnQkka9TqTDh0Zb/XfrzNdRZq3MTBxHLXAfPVXRZUouwGafpRmyZ/D4l5xa9ojXOp4H27qGq0XvkY5JpA1jAbdxaSJtTZldXK3ibb34VW6CQMjvjdFD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126949; c=relaxed/simple;
	bh=twdcoEffjeKcQGckExnNAc4g2q6luyRhNHlxWdW4IMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naWU1mQZ2U+nOkRP5dKE9f0OQYkc5HmWJ6/zVCnOUijFbzIjRsuLh0X+MdmPL9i+bJdUGhAkyxNayQW/fyjrAxTeLiLRgLRX3FDK2k1frvCoeHuPC7o6DVCWTrLz4Vu6d7SvBrxsU1GmvedK+53tbKBxQtwbOuBpkOeBK3zGY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MtSD+jbR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MtSD+jbR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCE061655;
	Fri, 11 Sep 2026 04:42:23 -0700 (PDT)
Received: from e129823.arm.com (unknown [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B760D3F59E;
	Fri, 11 Sep 2026 04:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789126947; bh=twdcoEffjeKcQGckExnNAc4g2q6luyRhNHlxWdW4IMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MtSD+jbRsa1Hwk5ypWNktiqZnPVKzIwIoLrzu4E1bqNG1rHD7WaBcpHVFdLG5ePHI
	 7ClBWEeuGvqH1rEuKu9EXpJ8TEisVXEMkCcXzSTtyqZKzrTkx0KCJlgYXfnAdA5PeH
	 AM40/OXfRIqFzx/ZhTOI5HG7DzkHq/VG90y2Ceoc=
Date: Fri, 11 Sep 2026 12:42:24 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 8/8] coresight: etm3x: introduce struct etm_caps
Message-ID: <aqPpIJk5FMlP2lPJ@e129823.arm.com>
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
 <20260911-separate_etm_cfg_v2-v10-8-1b715d95927a@arm.com>
 <20260911112048.CA1AD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911112048.CA1AD1F000FF@smtp.kernel.org>

On Fri, Sep 11, 2026 at 11:20:48AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The local variable `caps` in `cntr_val_show()` is declared and initialized but never used, leading to a compiler warning.
> --
> 
> commit 95d091834d6fbb955b9c3143fee9373f3398b6c9
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
>     coresight: etm3x: introduce struct etm_caps
>     
>     Introduce struct etm_caps to describe ETMv3 capabilities
>     and move capabilities information into it.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > index 0701edc094581..6c911b8c1be96 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> [ ... ]
> > @@ -719,6 +724,7 @@ static ssize_t cntr_val_show(struct device *dev,
> >  {
> >  	u32 val;
> >  	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	const struct etm_caps *caps = &drvdata->caps;
> 
> [Severity: Low]
> Is this caps variable necessary? It appears to be declared and initialized
> but never used in cntr_val_show(), which might cause a compiler warning.
> 
> >  	struct etm_config *config = &drvdata->config;
> >  
> >  	if (!coresight_get_mode(drvdata->csdev)) {
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com?part=8

Right. I'll remove it in next version.

-- 
Sincerely,
Yeoreum Yun
