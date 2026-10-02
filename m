Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6583382CB;
	Fri,  2 Oct 2026 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960578; cv=none; b=aKwO2AdqOSNIz19hth0RBZf+sgHJY/bt1b/U/xF/GpfEtUczNUxW87tkjcxO14nG0JNRJ0SFJ++1+AQCuiZPZywwc9nxj6RPgzB7HB0jj81mLOvdBo5Tfg1Gtsjq4rhqhEvF/VnW9fu/KR4eAkmCVDVuhPowv0qndcRto7Yylo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960578; c=relaxed/simple;
	bh=AujEG1ysY5IJFtWwYdnh06UeIW4r3DOKSApXusGeGxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DraUjlENzePqxt0krx3DPXZjAduAmQ1XSBiG9jzoJp6G5adufjx+Q8ZpCeUGNGk37JViwu1ig6UvSr0qyDXkoKUWJoRsUkEAIEpcLPUxf33vrJAYCQH00RZBtX6pFVo/+NOIR8mcWLpFbF7e8NL2hyelIpJ8DsfKlcFSWA5aA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Htjy25Ij; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Htjy25Ij"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CE602F;
	Fri,  2 Oct 2026 10:02:53 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E085A3F86F;
	Fri,  2 Oct 2026 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790960576; bh=AujEG1ysY5IJFtWwYdnh06UeIW4r3DOKSApXusGeGxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Htjy25IjFnqUGOnh4KBghZ8ryIF0YjUJg8NYh2au01V2VpYWUdp4QJ1JmaqcxfnJc
	 dgBkdgtnJVzGBtFQ0zi6K+yhL7TltxajxflAMNlUHxD7Ng7dr3U3QbdrmsHeJaZgV5
	 vVl7jIvT3o7KVpjvkg0iP/tLiXO9q/aJ+c1JCATM=
Date: Fri, 2 Oct 2026 18:02:53 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 01/14] coresight: etm4x: read-back TRCSEQSTR at
 disabling and prohibit modifying seq_state while enabling.
Message-ID: <ar_jvRE0C0Jb8WDE@e129823.arm.com>
References: <20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com>
 <20260924-separate_etm_cfg_v2-v12-1-a2b41d2f7c2b@arm.com>
 <20260924174611.917571F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924174611.917571F00893@smtp.kernel.org>

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] coresight: TOCTOU race in seq_state_store lockless mode check
> - [Low] coresight: misplaced IS_ERR_OR_NULL(drvdata) after dereference
> --
> 
> commit fb240199cfa6db080873efbe2c007beb70c01070
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm4x: read-back TRCSEQSTR at disabling and prohibit modifying seq_state while enabling.
> 
> TRCSEQSTR can be changed by the ETM while a session is active. Its value
> therefore needs to be preserved when a sysfs session is disabled so that
> users can read the current sequence state after the session ends.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > index cc6cdd3ae29d5..db3cf4ad6806c 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > @@ -1437,6 +1437,8 @@ static ssize_t seq_state_store(struct device *dev,
> >  		return -EINVAL;
> >  	if (val >= drvdata->nrseqstate)
> >  		return -EINVAL;
> > +	if (IS_ERR_OR_NULL(drvdata) || coresight_get_mode(drvdata->csdev))
> > +		return -EBUSY;
> 
> [Severity: Low]
> Does this code introduce a regression by checking drvdata for NULL after it
> has already been dereferenced?
> 
> Looking at seq_state_store(), drvdata is dereferenced during the check for
> val >= drvdata->nrseqstate before IS_ERR_OR_NULL(drvdata) is called.

Yes. I'll fix it.

> 
> While drvdata is fundamentally guaranteed to be valid in this sysfs context,
> making the check technically dead code rather than a reachable crash, should
> the validation be moved before the dereference if it is kept?
> 
> >  
> >  	config->seq_state = val;
> 
> [Severity: Medium]
> Could this lockless mode check cause a regression?
> 
> A concurrent thread could enable the trace session immediately after the
> lockless coresight_get_mode() check evaluates to disabled. This would allow
> config->seq_state to be modified while the session is actively starting or
> already active, completely defeating the patch's stated goal of prohibiting
> state modification during an active session.
> 
> Should raw_spin_lock(&drvdata->spinlock) be held across both the mode check
> and the subsequent state update to prevent this regression?
> 
> >  	return size;
> >  }

This doesn't matter, TBH I don't expect user concurrently setup the
configuration while session is not ended yet and similar problem
is already exist before separation of this patch too.

So, this is ignorable.

-- 
Sincerely,
Yeoreum Yun
