Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FFC3E92A8
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Mar 2026 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461114; cv=none; b=B4+6W/I1hDL6XJGWnLUJBG1OtR4guFZPSHXloC7sxzl95Z9FhklpPsiG57XWY12BYts4HunvV4bWz4GaLWylm1p0Jm6CJxsLte2r/sbvNIqLHdCU0kaNKgs4wD/SbPbyRIhzcjiAjwtq8UHqUt7RhKyWCuymjlHb3L8F+KEeNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461114; c=relaxed/simple;
	bh=L/8zDjgtSFZmVSmjSqHJHCta+U8SwGgkTlm5rzE08pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i19KMHUdOKlm+LEyYJXXnC5YtdOIfW1qmm9RTFjuslsbvboDfuPfge/HiOm/p3BBobU5FBtikM2Nw/dPdSZZlDplI497p0cqf6sk42IUsO8dqZ9c+kWsetYJEHNlK8fhfP9NMNr+hZvFHE+Nm2jredd9zt7lNB5a2dfIEq/WCK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J38q7Xv1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IQp60mWq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J38q7Xv1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IQp60mWq"
Date: Wed, 25 Mar 2026 18:51:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774461112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yLq4Jaj2bWJywT+RQOdtAWoXk+H0RLsWlg/o+qTEiw=;
	b=J38q7Xv1iLdrYQcUJVTaIlzEnpNJ6ugyd/9DXukshlq8DdYWo6rFaqqqt7KUF/vXB3O7YM
	Gj7gx4BMQuMfaLfDplA0xHU05tPz6Y8q21pCGKQRXbsfqXKM9ptnEwKMQdZX4UDeWRCkil
	6FNU5XohBT1m/88GaUQT7yzfl8/CkqeczbTTg4vj/pc57KXf76sPX7fiKV13XMBo7wiR2p
	udFNrrzvRtCDynmiDPWFmllpzVOunS7z0nCxEDMkq5EE5kDr/BGGmJSbOoBqWAqvvsy1Zj
	WaMCjY/rzZPu0j0qqOg2AzRxe0p3xX9Pqol2Rcth9HA+GTY0nE1snUk3+NGxyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774461112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yLq4Jaj2bWJywT+RQOdtAWoXk+H0RLsWlg/o+qTEiw=;
	b=IQp60mWq9ZFOWTO5Vds1uhyTPyvEJzhPD221JdzJSzxOCRFqcYuZah/DsAFY8I9umPLTid
	CyKu4DibnnOY9wAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
	Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v1] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Message-ID: <20260325175150._IrYQldq@linutronix.de>
References: <20260325030508.321405-1-jiayuan.chen@linux.dev>
 <20260325111351.1d38a0bc@gandalf.local.home>
 <20260325153826.EbSqlX_n@linutronix.de>
 <20260325115315.052e34ac@gandalf.local.home>
 <20260325155504.tm4zHWMI@linutronix.de>
 <5b6f6480-aa2d-4966-b3c7-6c719e915285@linux.dev>
 <20260325170539.MHkr49jU@linutronix.de>
 <20260325134433.7d46507d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325134433.7d46507d@gandalf.local.home>

On 2026-03-25 13:44:33 [-0400], Steven Rostedt wrote:
> On Wed, 25 Mar 2026 18:05:39 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Why not just having the synchronize_rcu()?
> > 
> > > Callers that free the containing structure would switch to
> > > irq_work_synchronize_free(), or use kfree_rcu() if appropriate  
> > 
> > If we provide the irq_work_synchronize_free() then using kfree_rcu()
> > would sort of open code irq_work_synchronize_free() since we couldn't
> > simply replace synchronize_rcu() with something else and update the
> > irq_work core side (we would also have to update all users). I guess
> > that was Steven's idea in providing a helper for synchronisation.
> > 
> 
> Yeah, the helper was just document that free work needs synchronization.
> 
> Perhaps Jiayuan's idea is better as it will not require modifying current
> callers and does fix the issue.

Don't you need to replace irq_work_sync() with this new one?

> But it would still need helper functions from RCU as I really do not think
> it's a good idea to open code the rcuwait logic.

Why is rcuwait a concern?

> -- Steve

Sebastian
