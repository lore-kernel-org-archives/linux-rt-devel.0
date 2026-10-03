Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652FBF9C0;
	Sat,  3 Oct 2026 01:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790992033; cv=none; b=C4s8SX2xxz0FEcHA7tww+o66MqB4FSFAFf9lAWWKw/WjQQucZrf6XFBtTEJx5pW5OQ+G3mYX1PHR/Z4rPpQGr+S47fxmBOXTaCio+kVrPW0Axb8HoBdxf9MZ4TCVYpE1ixA5X0264XXM1HJ+SV1WdHW1RnmMj7+PEfWSlPlKZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790992033; c=relaxed/simple;
	bh=Hze6mH8aYSwD1FKFdLzj92kZ1I8qCBuFF39vCWG7tFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6Hx3sL8Ro7nzdSquMdgosrXCuGWLfE/BfF3oEU2Oe3CgfgMQ8uYE6Sm+B9NNl8oo86rIiee1BZilVeg72qBzZ5s6hSYWIKvql4tSF+RwhgijqsvgdGde3MIcJzQh+ys0yscw4HJHR4U6YBD0P5+WUeObku/dEUg/jx8sz01x4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=C5E6UicJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="C5E6UicJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FE0E2F;
	Fri,  2 Oct 2026 18:47:05 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDB1C3F85F;
	Fri,  2 Oct 2026 18:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790992028; bh=Hze6mH8aYSwD1FKFdLzj92kZ1I8qCBuFF39vCWG7tFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5E6UicJlhiNtCgjWR70eki6KzVaGw9msEidonYpHliLcwiPyVaRYdsOccRdQOa5V
	 y4dHpn5KNntcZBPFYJKjIPax5K8lwHaVae7/6NtX3TdRk79rbGHEoAIa288JgxeWme
	 7wY61ZFX5JrMIRc7TYxhFczMhrWFO13wVGJwV4Dw=
Date: Sat, 3 Oct 2026 02:47:05 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v13 01/14] coresight: etm4x: read-back TRCSEQSTR at
 disabling and prohibit modifying seq_state while enabling.
Message-ID: <asBembnuv672-hcJ@e129823.arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
 <20261002-separate_etm_cfg_v2-v13-1-fe429d8d96fb@arm.com>
 <20261003013345.9CAB71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261003013345.9CAB71F000FF@smtp.kernel.org>

On Sat, Oct 03, 2026 at 01:33:45AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] null-deref: NULL pointer dereference in seq_state_store() during probe
> - [Medium] race: TOCTOU race in seq_state_store() due to missing spinlock
> --
> 
> commit be18b7cdd3b23e4d67d68cc4591ca50a52fb8ee1
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm4x: read-back TRCSEQSTR at disabling and prohibit modifying seq_state while enabling.
> 
> This commit copies the TRCSEQSTR value when disabling a sysfs session. It also
> prohibits modifying seq_state while the sysfs session is active to prevent
> those changes from being lost when the session is disabled.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > index cc6cdd3ae29d5..2c72ea831fe65 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > @@ -1435,6 +1435,8 @@ static ssize_t seq_state_store(struct device *dev,
> >  
> >  	if (kstrtoul(buf, 16, &val))
> >  		return -EINVAL;
> > +	if (IS_ERR_OR_NULL(drvdata) || coresight_get_mode(drvdata->csdev))
> 
> [Severity: High]
> Is there a risk of a NULL pointer dereference on drvdata->csdev during device
> probe?
> 
> coresight_register() exposes sysfs files via device_register() before
> returning the csdev pointer to etm4_probe(). If a user process accesses
> the seq_state sysfs file during this window, drvdata->csdev will still
> be NULL.
> 
> Because IS_ERR_OR_NULL(drvdata) does not check drvdata->csdev, calling
> coresight_get_mode(drvdata->csdev) may dereference a NULL pointer.

Thanks. This is typo and I'll fix it/

> 
> > +		return -EBUSY;
> >  	if (val >= drvdata->nrseqstate)
> >  		return -EINVAL;
> >  
> >  	config->seq_state = val;
> 
> [Severity: Medium]
> Could this assignment result in a TOCTOU race condition?
> 
> The mode check and assignment are performed without taking drvdata->spinlock.
> If a user writes to the seq_state sysfs file while another thread
> simultaneously enables the trace session, the lockless assignment could
> overwrite the state even if the session becomes active.
> 
> Other store functions in this driver correctly use
> raw_spin_lock(&drvdata->spinlock) when modifying configuration state.
> 
> >  	return size;
> >  }

This will be fixed by following patch by separating the curr_config and
active config. so ignorable.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com?part=1

-- 
Sincerely,
Yeoreum Yun
