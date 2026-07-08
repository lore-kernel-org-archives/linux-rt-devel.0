Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE33F12C7
	for <linux-rt-devel@lists.linux.dev>; Wed,  8 Jul 2026 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524265; cv=none; b=iWDixOi1q95mlYjf9IDOM7xp57P01xxw944lhzUrpNVa+33MuEcY0k7C79oQasDLYPWSmQfLLOclPVhlRY977Kq8mJUy34ahXUoxyFTPM3W4JN6WnGea4FlLtOFR7xwwyPZSfXj9olK+JRhWgxfbOy3NLNFSyD4c1lNTflMSvdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524265; c=relaxed/simple;
	bh=jglJtMgeUyWa6n8zEnVsMKXnKVEICn3GMbuj/cxnkgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XiXmj2p6mD+mevZk96eZlDznpmjSqKU6CJVtwVEqVTRMfwaK2cv6wuraUUHeYJZqWqsE6macy4lnyF/2hbGGpiVLYa/Jmxh4669oUvxE7BhgVdPMnfFzyps4hENyf/WdWD87QoUM2UOEURITUdNyE8OTAN6/IVcnnvL9o0L64r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k9ZY/UxC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZoeU5/gX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k9ZY/UxC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZoeU5/gX"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783524261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jglJtMgeUyWa6n8zEnVsMKXnKVEICn3GMbuj/cxnkgk=;
	b=k9ZY/UxCZbSsH/rc098SAyI0bHPPVWzpzgVkApB/wzpkIFccGmCq0YuqclYloDvH2whtVC
	D6M8VQKt1J/GEhjkE6EU6pykSuTzEDJkT30cJmyOoq+VJnkxR/1gwpow2xbVo1gB5OYyfM
	RaYcJ8gf8UA+5LbL5eSEzjavxm2tQ3rIwkFzunJPiVpKsHjyeegej20TOmCwX1IaL42MuF
	kz7ORl1WHlQTc/2dcbDhcP3YWj27KZ0IXKpsoYCGb8fwlRr5HJ8QGa6+nRMGgVg1UXiYv1
	+Dol3Li2DRlD9zzI879vxtof5+fQy9S1t8XYz0IOfCFmmdo5wFFv+uTfzKBQ7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783524261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jglJtMgeUyWa6n8zEnVsMKXnKVEICn3GMbuj/cxnkgk=;
	b=ZoeU5/gXaDY/oKKzK/5TkBRN6U5CpSFPHCR1L5QTwxQPs68Awdxbr1e3D7rkoeiasUdje8
	NeyuTroDF3XyJvCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Benedikt Spranger <b.spranger@linutronix.de>, Andrew Murray
 <amurray@thegoodpenguin.co.uk>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 3/4] printk: nbcon: move printk_delay to console
 emiting code
In-Reply-To: <ak5oFk3Snnt9Wr95@pathway.suse.cz>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260703165654.71be8707@mitra>
 <CALqELGz-KSrGq5JYvLedZiO-p21pjpRKbceO+jiSfwZGyx+91Q@mail.gmail.com>
 <20260707145411.53a10893@mitra> <ak0VguIf-PxmbUOS@pathway.suse.cz>
 <87qzldvqpm.fsf@jogness.linutronix.de> <ak5eCp5qw9LYrnAH@pathway.suse.cz>
 <87zf01ttve.fsf@jogness.linutronix.de> <ak5oFk3Snnt9Wr95@pathway.suse.cz>
Date: Wed, 08 Jul 2026 17:30:20 +0206
Message-ID: <87wlv5tsgr.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-08, Petr Mladek <pmladek@suse.com> wrote:
> Now, the question is how to move forward. It would be nice to
> have the sync mode available before we add this boot/printk_delay
> clean up.
>
> Would you have time to prepare and send a patch anytime soon, please?

I can work on this this week.

> Or I wonder whether Andrew Murray might try to create a patch
> based on your "SYNC IDEA".

I expect that the two series will not conflict. I am just adding another
atomic printing path, but the Andrew's delay is implemented deeper.

John
