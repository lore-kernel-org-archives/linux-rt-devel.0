Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FFC381EA9;
	Sat,  3 Oct 2026 04:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791001800; cv=none; b=qG49wxCeJl8DqiWlUtgaxNK02njY24+gPDlRcE67WZOS0u3v2Ywl5PZmMeZLq4h07C4uZypIprV2NI4LFO9GG05HmBCKEYU39r9dZCbCGZGUyrK5S/WhxKhGME+MTFGqJdPS53pHl7a681Pt/XyzfNOmANxiaYnrgpnGildjgx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791001800; c=relaxed/simple;
	bh=HvgYTZ+hfvvwapZljLnzU5xbUPpFttewIzgXvs9pkds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo+ERt1vjcNiULCdnknMNKCYPjuDpbMXy7teBOiaYOc6Pa/pgDF8S1eZPdpJrBmZLCALnjdFh8rZ6+nCgUgQSwBiF0FgZydGH0EAtM6amoFv18s0bVEtQe8m7z3Q3pupHHc5lovxabRaJ2VCcvWWJsF1rUaI0MF3mEVvv7IwLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HTtiil69; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HTtiil69"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04E8F2F;
	Fri,  2 Oct 2026 21:29:54 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80B173F763;
	Fri,  2 Oct 2026 21:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791001797; bh=HvgYTZ+hfvvwapZljLnzU5xbUPpFttewIzgXvs9pkds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTtiil69HdFL+qXPiOy7vJ3lQ7QcfpxDg8OabHAkkS0kE0md6EoKxMRH+h75XD3md
	 Q0sqMxC32km8qRPcD0eEBuwwphkarEqJoYZ0GAq/aSY4J+Wzof7EUfXOssRCDa+F8U
	 J4/nzznhK2dxOax7xvegTB2ebc+zS2lC9SIGnyAs=
Date: Sat, 3 Oct 2026 05:29:53 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v13 02/14] coresight: etm4x: prohibit modifying
 cntr_val while session is enabled
Message-ID: <asCEweXY4UIyqMas@e129823.arm.com>
References: <20261003-separate_etm_cfg_v2-v13-0-5d8a29aead95@arm.com>
 <20261003-separate_etm_cfg_v2-v13-2-5d8a29aead95@arm.com>
 <20261003030639.BB3AA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003030639.BB3AA1F00893@smtp.kernel.org>

On Sat, Oct 03, 2026 at 03:06:39AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] coresight: TOCTOU race in cntr_val_store due to lockless mode check
> --
> 
> commit da77274417a7a9a1e577464873f49041c777a7fc
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm4x: prohibit modifying cntr_val while session is enabled
> 
> This commit adds a check in cntr_val_store() to prevent modifying the
> cntr_val configuration while a Coresight session is enabled. It returns
> -EBUSY if the session is currently active.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > @@ -1615,6 +1615,9 @@ static ssize_t cntr_val_store(struct device *dev,
> >  		return -EINVAL;
> >  	if (val > ETM_CNTR_MAX_VAL)
> >  		return -EINVAL;
> > +	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> > +	    coresight_get_mode(drvdata->csdev))
> > +		return -EBUSY;
> >  
> >  	raw_spin_lock(&drvdata->spinlock);
> 
> [Severity: Medium]
> Could this leave a race window before the state is modified?
> 
> Since the mode check is performed locklessly before acquiring
> drvdata->spinlock, another process could enable the session concurrently. If
> the session is enabled right after this check evaluates to false, but before
> cntr_val_store() acquires the lock, the configuration update would be lost.
> 
> The concurrent enablement would set the mode and call etm4_enable_sysfs()
> to program the hardware. If cntr_val_store() acquires the lock after this,
> it updates the software state which is never flushed to hardware for the
> active session, and will eventually be overwritten by the old hardware state
> during session teardown.
> 
> Should the mode check be moved inside the spinlock critical section to
> properly serialize with session enablement?
> 

The puprpose of this to prevent modification after *session* is fully
enabled since the cntr_val is overwritten after disabled.

IOW, while enabling the cntr_val is not matter and this secnario
couldn't be resolved by the locking -- it's matter who take the lock first
while on concurrent contention between store vs enable also, it's
pre-exist behavior.

Since we don't expect user try to enable before it finishes to config.
Therefore, this is ignorable. 

-- 
Sincerely,
Yeoreum Yun
