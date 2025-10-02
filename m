Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E61482F2
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Oct 2025 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384149; cv=none; b=BlU57dxLdDm4DYXH48C4Q+z6yYGmZGrTEGkch08vr+broB7POMg3K23ZQvoteqkQR7HB2sJX45edteNkhoAvc2MXBp7pRboTNCbhGsD4vGZpYZvxmYTM/BPCRUvytjkcoQzYz+NpRNk86Se5NNL7C3lUa0Dmpm3jgOw8mBCJLCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384149; c=relaxed/simple;
	bh=AQNh8cl+UP6HP61SWL0KP/oGum5WucbUdW7ZyughBfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJItu8eme6zDh332xdNxPwavqMNS87H090V7bPV/HOroQTl8meofmHjxu2FdE1+W356V6Fx/WngOr57czx272Wr+gSnojFo1Sll14DkuSooqSrzPTCmvXmNcZHrK7MiX6Gxi40SK0PBOGbqGzFunRNjJPuXH0J0ynlocSocnsyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tcpAY8JH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r+meClwa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tcpAY8JH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r+meClwa"
Date: Thu, 2 Oct 2025 07:49:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759384144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Apy472Q5lq+nvgjNXR3cJzIlxGGISyrJR6P8kOYm75c=;
	b=tcpAY8JHSt9mbrTZ/obJhPEGIf2beBd1A06NbUI7Oea1aUFzRqKt5wgqOKdI5QCTRIeYbR
	hs365pHH4k4JzfQNUfFbnLi+qyUo8VpQXO3dJwd2DkP+OmRbxALBTM8JG5KTGWMv1/W7TR
	eaiKDXGyr9K3mm+7ZtHrE6X/zFCImI9GizbQJ84It1L68IYkgrm7qHiVnQw42XL2mPZ21Q
	FuFPmXuRok5CPSbPyMGal1l3xH6SHealP/Z4wJUJcJlFm9tS7x636mWEbetSG5wo/By/kY
	q9j1ApdxdWhnMa7xcrauj6mARqwC57WuKbbLRIAcIy3E9m+ZpaMOPQ6Ngwx4Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759384144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Apy472Q5lq+nvgjNXR3cJzIlxGGISyrJR6P8kOYm75c=;
	b=r+meClwaSKfKlU2B+io9towu8KpVPixcx7Jo71rM4IIjjXkrJCdUmasKt1PInYY3ejZ9cP
	qr+v8Oq56KVzFuDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tiffany Yang <ynaffit@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, cgroups@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
Message-ID: <20251002054903.kzlPcvnz@linutronix.de>
References: <20251002052215.1433055-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251002052215.1433055-1-kuniyu@google.com>

On 2025-10-02 05:22:07 [+0000], Kuniyuki Iwashima wrote:
> syzbot reported the splat below. [0]
> 
> Commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> introduced cgrp->freezer.freeze_seq.
> 
> The writer side is under spin_lock_irq(), but the section is still
> preemptible with CONFIG_PREEMPT_RT=y.
> 
> Let's wrap the section with preempt_{disable,enable}_nested().

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
