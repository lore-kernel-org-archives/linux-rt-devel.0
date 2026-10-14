Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE124F052F
	for <linux-rt-devel@lists.linux.dev>; Wed, 14 Oct 2026 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990703; cv=none; b=ugVsw2z3s2ZL4hEe56uV2kwDRJA/CAK/mw5qeQ3+ogT2nIweoMmRByZwSAn36Z0l/oc+Uf8abGH/zSbaVcA1pNGBWDCA6myd1WQ+7jDhI9RVgDvgO3nmtZYF5qkhEFjFvknfQT8ZRGJFsNSBMtUB61NAINFO7XX+bvqN1gjRpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990703; c=relaxed/simple;
	bh=oVSmRMCRjNnaVcOLK5jTFdz5/PoMO2iCpy5TPWVCdu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVV44XcNByYwxjT/4eTgwXUydRXk+Ez/zA7TZdWsC8pmGFmCzvaMtH8hNxCzZND9dNc8IgZtt9njWSgp2lOlGY3q/KQccvOl8gfEEouwk/NOHf3yNcFCMow5RvRclFj2W0FJS+co46e0ZSvjrnSkDl00CLth+e1VIA1jHFmb3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KLakZJpz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W+ky7fZN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KLakZJpz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W+ky7fZN"
Date: Wed, 14 Oct 2026 17:11:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791990699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FZj1yfHOZvhvmJMIGeuhNq84M63Ee1+lzSanZrnjUiQ=;
	b=KLakZJpzuSdbZZVjyMnPtlLjgeWGEmGjZ06IBJZqzJKaxKIIs2ag9WrcIm3eMDYIaS0zLb
	6jvoJ1oRj4PuZvBRXis2Zl3TQBZB4eLW67Au6afVHuCyQH30vm/QrOaQmIiRNYwkKfszdJ
	3UC9USs9ARQf+GLyQg8S3gAos7aRm8vztOvuHcXRSD6lJrImeJW6uHsYJNksKL3U3cVupf
	vlAbwPeB4NG+25BuwOcsSSH5Pn2ruHL2Ss4mEKGG3+ykSRHonzLq3nWXIUucvaNqV8h9sv
	eeiqDst3y+YAWoqyFbhKHmLr9y69DLpp+lsPuK82SaP7vPzMSulBC8Jk16jv/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791990699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FZj1yfHOZvhvmJMIGeuhNq84M63Ee1+lzSanZrnjUiQ=;
	b=W+ky7fZNErOKQMOPPToR1Ji/lWG+lfyRfuCtIhzhWLgzkw/Id87ImcWxFREgvE1WJASzom
	OL+oiVh/tfEBVBCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: wen.yang@linux.dev, Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v6.1-rt 00/15] net: Backport backlog-NAPI threads to
 resolve PREEMPT_RT softirq warning in SMP flush
Message-ID: <20261014151137.-fFJKa4D@linutronix.de>
References: <cover.1791912669.git.wen.yang@linux.dev>
 <20261014150853.f8I2fNx0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014150853.f8I2fNx0@linutronix.de>

-net folks and lkml
+ linux-rt-devel@lists.linux.dev

On 2026-10-14 17:08:55 [+0200], To wen.yang@linux.dev wrote:
> Please keep the networking folks out of the loop. This is a backport
> request which goes entirely via the RT-queue.
> 
> On 2026-10-14 01:58:34 [+0800], wen.yang@linux.dev wrote:
> > From: Wen Yang <wen.yang@linux.dev>
> > 
> > *** Overview ***
> > Backport the backlog-NAPI smpboot-thread mechanism and its prerequisite
> > NAPI/RPS/defer_list work from upstream (v6.4 - v6.9) to v6.1-rt-next.
> > 
> > *** Problem ***
> > On PREEMPT_RT, RPS steers packets to a remote CPU's backlog by sending an
> > IPI. The IPI handler (rps_trigger_softirq) calls ____napi_schedule(), which
> > raises NET_RX_SOFTIRQ. do_softirq_post_smp_call_flush() then sees a softirq
> > pending that was not pending before the flush, and NET_RX_SOFTIRQ is not
> > masked by SCHED_SOFTIRQ_MASK, so it fires:
> 
> I was about to point out that v6.1-RT should have duct tape for this but
> from reading 1/15 is see that this duct is not complete and is missing
> RPS. Indeed.
> 
> A backport of what is merged is my preference, too. However, we should
> get v6.6-rt fixed first then v6.1-rt. Otherwise users upgrading from
> v6.1 to v6.6 will have this case broken.
> 
> Clark, any objections here from your side?
> 
Sebastian
