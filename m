Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BD1201033
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Dec 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764674809; cv=none; b=CJNXoj6Qx4gW4nJUYGymu5owyPI2i2tEHRwv8HeINBpqLG+JDiC0RLKm+ZaOOdhYlIUlf6z33NE+//uAirtbJa4ZBBJXvMTQlRimAvHYMX2m+ewNJBcsZEr3rscG6hJPG1JOt8Te2ieKtn/jCCgTdPQWMgES0ZV4fn/2tv82rIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764674809; c=relaxed/simple;
	bh=/dDGH8D1gqcEMVmvtKj82E4K6HuWoRznSA0hr6k30NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNPNJ9ttEN125xlWnHsJEmbbvNeSANbmYS1L7ix/72MK5x/WIw6sGsVudQstZmUXWmkt94dgNx0WgYbyI3VFiuBMvqGAm3SIBq3N9zOhYi2vt8ct14Oj9ukqva5T/PcXTZCCbKZh5esqfarNkjvdBzz3n7LPrwAkPw2xfVEAXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHWCIUe+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swSX6nZS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHWCIUe+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swSX6nZS"
Date: Tue, 2 Dec 2025 12:26:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764674806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/N86RDwIaVj+vLARd32xnS6V6r8Cx082J61AaM9TUI=;
	b=GHWCIUe+zKwWbu/J7dbuXcawU4ORylGiFZoB/QyyFEj+EqmIDimwZXedGpgbhXRSzmwGFQ
	A9TNH/b2gp8n3SFmz2u7LfTnM+NIVYLLVmOeg2z5tDEeG+rST2rcTPTFI49/6oaSFQGafe
	GApPg5MU6vsghHdgk3/nKVX5+ZYrJESakaMnkNXp9moGL3czo+H/UNBz2t8b+EA8A7lf3F
	Oay016UeXhFzKZHxVw7JaJ6UdPShvDTYbOqopyzbsL9iligMdiIsbDnratbytJvDyo2f+S
	9r/aaaPab7VfJCSwAWJvnOg25XgwRCRSZP/3SbWoXWWsFGJdBbtI3q0edPR/pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764674806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/N86RDwIaVj+vLARd32xnS6V6r8Cx082J61AaM9TUI=;
	b=swSX6nZS8CDzDkKxTlO3+xbuaFr7meeXwueeTt7C7nnZJHHZID3GrBDXpvFcF7p46C0/2F
	0EnxxvVcZ8PfTTDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Yunseong Kim <ysk@kzalloc.com>, Nam Cao <nam.cao@linaro.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Byungchul Park <byungchul@sk.com>, syzkaller@googlegroups.com,
	linux-rt-devel@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via
 RV (Runtime Verification) monitor rtapp:sleep
Message-ID: <20251202112644.YUux4LKd@linutronix.de>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
 <87fraslu9c.fsf@yellow.woof>
 <87jyz5kuf2.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jyz5kuf2.fsf@yellow.woof>

On 2025-12-02 12:14:09 [+0100], Nam Cao wrote:
> > RV is not a static checker, it is a run-time checker.
> >
> > Just in case you are not aware yet, there is also Smatch:
> > https://github.com/error27/smatch. But I can't offer much help there.
> 
> I was looking up something unrelated, and I found that Smatch does
> detect this sleep-in-atomic problem:
> https://staticthinking.wordpress.com/2024/05/24/sleeping-in-atomic-warnings/
> 
> I'm not sure if its design takes PREEMPT_RT into consideration. But
> seems worth having a look.

It does not look like it does. Judging from
	https://github.com/error27/smatch/blob/master/check_preempt_info.c

it increments the preempt-counter on preempt_disable() and spin_lock().
So it won't yell at
	preempt_disable();
	spin_lock();

while CONFIG_DEBUG_ATOMIC_SLEEP would.

> Nam

Sebastian
