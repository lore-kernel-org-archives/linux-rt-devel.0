Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D951A22D4E9;
	Sat,  3 Oct 2026 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790999083; cv=none; b=qvgJVQ7XZllvZ3v3N4ilIRccP7DHzYfIRRCnqLfmFVBcaCSKcOHckx8W2Olv6ImhoR7sopXvetVzBLmOcXUQYgp9NRI3db0QsrwMAhUmjKCACPl/Ec1dFUvRB9NJRSCdpazy7of2QEMIrynXL0HvALpnFAGwjbmziIPKuH2Y9pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790999083; c=relaxed/simple;
	bh=GrLpAvXzF80DRMTpDhRj/qFzvX9wlVwcGV/DBEqFkVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkHbrxpqUdGM3wgykUc0H0OzcoewtJ3C5spV2YxrxZZ1/SlD6aGo+QVKHLID5DfFX86BFVHOArGUskVzAcjIZ6J5K+ucMFct9yWRzkCDmp800KIO1fb+kqxzARVOnk2XCh/DExgqwv/QgYwE98jpteXP07IHs5V0BeCBSHb9WAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IpfQ2zNb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IpfQ2zNb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D60F02F;
	Fri,  2 Oct 2026 20:44:37 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9538E3F85F;
	Fri,  2 Oct 2026 20:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790999081; bh=GrLpAvXzF80DRMTpDhRj/qFzvX9wlVwcGV/DBEqFkVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IpfQ2zNbp2th4W30ULSz/Z5k0u7bDMkB6S3AmJEXiFg+C7Cs1y9i+5vmZYbsFTyXq
	 fR2QBdTBGTbNtu85ZEsoRhI/WciOaKTHCK42wZCqEWXsSXKHq22pthbNkNorY9uuUE
	 Hff1KGEaTQSmCOxiUJBB4EiB90WR7IzA+JldMuDI=
Date: Sat, 3 Oct 2026 04:44:38 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v13 01/14] coresight: etm4x: read-back TRCSEQSTR
 at disabling and prohibit modifying seq_state while enabling.
Message-ID: <asB6JgDE6S6JQr4r@e129823.arm.com>
References: <20261003-separate_etm_cfg_v2-v13-0-5d8a29aead95@arm.com>
 <20261003-separate_etm_cfg_v2-v13-1-5d8a29aead95@arm.com>
 <20261003030811.B35331F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003030811.B35331F000FF@smtp.kernel.org>

On Sat, Oct 03, 2026 at 03:08:11AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] coresight: TOCTOU race in seq_state_store bypasses active-session guard
> --
> 
> commit 750a64ecfab03057a253043e06b3def402bb7137
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm4x: read-back TRCSEQSTR at disabling and prohibit modifying seq_state while enabling.
> 
> TRCSEQSTR can be changed by the ETM while a session is active. Its value
> therefore needs to be preserved when a sysfs session is disabled so that
> users can read the current sequence state after the session ends.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > @@ -1435,6 +1435,8 @@ static ssize_t seq_state_store(struct device *dev,
> >  
> >  	if (kstrtoul(buf, 16, &val))
> >  		return -EINVAL;
> > +	if (IS_ERR_OR_NULL(drvdata->csdev) || coresight_get_mode(drvdata->csdev))
> > +		return -EBUSY;
> >  	if (val >= drvdata->nrseqstate)
> >  		return -EINVAL;
> >  
> >  	config->seq_state = val;
>         ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: Medium]
> Could this active-session guard be bypassed due to a Time-of-Check to
> Time-of-Use race?
> 
> If a user-space write to seq_state and an enable_source call occur
> concurrently, is it possible for enable_source to succeed immediately
> after this mode check passes?
> 
> If coresight_take_mode() succeeds in the racing enable_source call, it
> would take drvdata->spinlock to copy the configuration for the active
> session. This seq_state_store() write would then proceed without a lock,
> modifying the configuration after it was already checked.
> 
> When the sysfs session is later disabled, wouldn't the old state read
> from hardware overwrite the user's new value?
> 
> Should raw_spin_lock(&drvdata->spinlock) be taken around this mode check
> and the configuration assignment?

No. seq_state_store() does not update any user configuration.
It only clears the STATUS and PENDING bits.

The other bits in TRCSSCSRn are RO or RES fields, so there is no
user-programmed state here that can be lost or overwritten by a
later hardware readback.

Therefore, the race described above does not result in a lost
configuration update.

-- 
Sincerely,
Yeoreum Yun
