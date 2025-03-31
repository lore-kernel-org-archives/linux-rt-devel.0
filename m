Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB422C190
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Mar 2025 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743402705; cv=none; b=i1A9F2Y8ns13PAH3OHdlLwNTrfu10Ko9AhATDRTBXxkEe2rBNOnKwLUCN5rFAQEWDwJBmJuBG6AioxGv88tI7Lwbk5qGtk8CQQDqyMkhmcV1dIOIGCms27kSZj/EuvFQ8lUQ83oA/gjC9zIJ8g60N+QcQevwqqBN2icWjAURYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743402705; c=relaxed/simple;
	bh=pYTeBGGNeVoXwp5ojPzGWOgsVkJWc8mQ1OBGANApyIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOitRupAIT+81siJtbPmUg8EF0xXz1M4/AUsQsp5IhN+Wo9bPvht57+zvtfUPYAcZ8m5s5Dci3xlPenaKCZCY5Dsl6/p6Agh1FROw4ePDKFI7UqqOkRO1yXi1HOCeoo2oy1H47oEZnjAkDL2hIYmDOSYrqrwOetFTwhpCxmf0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eNGaZkpA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ptqdCzMo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eNGaZkpA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ptqdCzMo"
Date: Mon, 31 Mar 2025 08:31:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743402701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nWiPCtZsNBQGbW3IC7zeNGTyRwdbh6wESTEfdtqa6s=;
	b=eNGaZkpAAJgJORLa7dZHG5Ji6DDWLN4GVZG0jFM65ajbPz64wbQcKLHMFmaFQwLSZbJF4H
	PdnfaLnbDoJwKjXpN7wgSPj0GHy85lCtfQXjT1HXLM0bVFOZBucP/5FzR8RAUulDGQW/oO
	jhlxHhthO/IUJROqcO6NMKTs5uiTiYz12F+UXsrQXsbQ5MBjKaRe1huhj91alhPbBsvje7
	PIidDbllCyPVZ52re1EYDkXh4xrtex7pQC2ztdICg+FNzDz5tTdrHK9JB1AFGqNp65RCuM
	Yj4DqqansvEfwtBmx6xUCiICclX9qkdgPZwYBt4E3lmbIsHoQWr53oBXxLAmvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743402701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nWiPCtZsNBQGbW3IC7zeNGTyRwdbh6wESTEfdtqa6s=;
	b=ptqdCzMoqiHwtqndOpvpeVBxzEotpL3K/NZierwbRiGd0MvT7y+9s3P5csYNO/juo9kmlh
	jRpuCF5jZqnf7CCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ismo 1. Puustinen (Nokia)" <ismo.1.puustinen@nokia.com>
Cc: "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: Re: Two kernel oopses
Message-ID: <20250331063139.WHL_PGTC@linutronix.de>
References: <AS8PR07MB8117D39772278625220157B085A12@AS8PR07MB8117.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS8PR07MB8117D39772278625220157B085A12@AS8PR07MB8117.eurprd07.prod.outlook.com>

On 2025-03-27 08:56:16 [+0000], Ismo 1. Puustinen (Nokia) wrote:
> Hi list!
Hi,

> I'm not sure if the kernel bug tracker is used for tracking the
> RT-related issues, so I thought I would also send a message here. This
> is regarding these two issues:
> https://bugzilla.kernel.org/show_bug.cgi?id=219919 and
> https://bugzilla.kernel.org/show_bug.cgi?id=219920. Briefly, on a HPE
> DL110 Gen11 system running 6.12.13 kernel (Talos Linux), I see daily
> crashes which seem to be related to the PREEMPT_RT kernel.

I don't know what Talos Linux is. Do you have a vanilla v6.12.13 or do
you have any patches (like the PREEMPT_RT patch for v6.12) on top?

> The first issue seems to be triggering an assert on line
> kernel/sched/rt.c:1035 . Based on my understanding, the
> nr_rq->rt_running value drops to 0, which should not be possible. The
> second issue relates to "not-present page" issue. I'm guessing it
> might be related to RT because I don't see it with non-RT kernel, and
> rt spin lock seems to be part of the backtrace. The crash occurs with
> various backtraces but seems to relate to address 0000000000000051
> each time it happens. The system has a Mellanox and an Intel NIC using
> mlx5 and ice drivers.

Both things are scheduler related and mess up its internal state/
tracking. I haven't see anything like it so far. It would be good to
know if you have any external patches or if you do anything else usual
to track this down.

> Any help or debugging tips would be appreciated! Thanks!
> 
> Ismo

Sebastian
