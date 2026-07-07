Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C373ECBEB
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Jul 2026 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783428855; cv=none; b=e5qXco4KDEzvuS68A3WgG6GuNaFzuOZJOcPYh4OD9XMKhCL3DDkt6qvC1/f2UWcKp2+nR9LAhd/RhATuFvP985yvz6/vY0Xhw5k46aZ4Lk3PBAOiuckHGTVf9vt7Z+NzFHZqt0GqzqJsLS37hXYnnKd5jkvj7Ygav1ECG5HOJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783428855; c=relaxed/simple;
	bh=coCOB5qqJ+X+DFURbG7Ogj2VXwfQ4/UW9Uydsi8FxI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcz4n63Mwq33unpFVBmc4hllNoU8cvJUuBZcypS2CyF1mj59ZzFzXwnsbGFk6WKNqlYoB6rfYvKhR2sZvfiN4TnEw9i3MHu8FeVZSoXWhlK1Lbpm0yIQBLAEOGXfXwmVl3LhjdWRI6TrqvbvFQqKvmbp1vGQBqoRn7EYLn61Tb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Eu4Dk0v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJ1gCCbN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Eu4Dk0v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJ1gCCbN"
Date: Tue, 7 Jul 2026 14:54:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783428852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/hv61aOydzHugwomfJNYebuZeFTkwhx/1G/+dLQAjA=;
	b=2Eu4Dk0v06ysm21QQr1mFBLNtn+bSKuW3OhImOytu9etUEFCC+cCkkaYxOXV39YPcf3o1t
	Gx83fOV9JLHklzA3T3vX5Tzgqv6wI/f7kjK+NgPh2lzm2Xcv29gzFnB3OlfBmdIJGtB8od
	DWxsVRx8gZbt5WCgqEfXzavgjgK+uqLLQ47Vhx63LmpTo5Zi6LxbJwtc1mh85+jo9yM3Zv
	DjKWNn9OJf1y63RBb72Weuq2QGPIlTnQX9iiq6/NeTixmwvilbd1XrmcrQ2TYq2wLzX38J
	LFJjbdtK0/h7qYyjmCbdlRdAI5ooVRt8bBs7XpzczHhrArizbVa5RG0cXrI1Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783428852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/hv61aOydzHugwomfJNYebuZeFTkwhx/1G/+dLQAjA=;
	b=WJ1gCCbNJ5O2SpMhyTBakk9vxkDQ3zD9r/Y9ROb779GAJXOW3JWWh29CrUsxt35SkmFFzU
	AsI6rUH/kDVI7kAw==
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 3/4] printk: nbcon: move printk_delay to console
 emiting code
Message-ID: <20260707145411.53a10893@mitra>
In-Reply-To: <CALqELGz-KSrGq5JYvLedZiO-p21pjpRKbceO+jiSfwZGyx+91Q@mail.gmail.com>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
	<20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
	<20260703165654.71be8707@mitra>
	<CALqELGz-KSrGq5JYvLedZiO-p21pjpRKbceO+jiSfwZGyx+91Q@mail.gmail.com>
Organization: Linutronix GmbH
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jul 2026 18:05:06 +0100
Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:

Hi Andrew,

> On Fri, 3 Jul 2026 at 15:56, Benedikt Spranger
> <b.spranger@linutronix.de> wrote:
> > On Tue, 30 Jun 2026 17:35:59 +0100
> > Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > > The printk_delay and boot_delay features are helpful for debugging
> > > as kernel output can be slowed down during boot allowing messages
> > > to be seen before scrolling off the screen, or to correlate timing
> > > between some physical event and console output.
> > By now, it slows down the boot process, which is the handy part of
> > that feature.
> >
> > > However, since the introduction of nbcon and the legacy printer
> > > thread for PREEMPT_RT kernels, printk records are now emited to
> > > the console asynchronously to the caller of printk. Thus, any
> > > printk delay added by boot_delay/printk_delay continues to slow
> > > down the calling process but may not have any impact to the rate
> > > in which records are emited to the console.
> > Using this feature to slow down the boot/suspend/resume process and
> > implicit make printk() happen, is the usefull part of that feature.
> > Imagine this sequence (which hit me on suspend/resume on i.MX after
> > shutting down all secondary CPUs)
> >
> >   printk("A");
> >   (do some stuff)
> >   printk("B");
> >   read from peripheral --> system got stuck here since peripheral
> > was not clocked or powered or both any more.
> >
> > The delay (and later on a ugly patch to make printk() synchrounous)
> > helped to locate where the failed access happend. JTAG did not help,
> > since the CPU got stuck --> no JTAG communication to that CPU.
> 
> I understand the use-case, you sprinkle printk's so you can find the
> point where a read to a register causes the CPU to stop. This requires
> that the printk happens before the read, and the output from the
> printk is printed before the read.
Enabling existing debug features in the kernel was a good start.

> > With your purposed change you *may* see "A", but never "B".
> > Quite challenging... 
> At present you may see 'A' and you may see 'B'.
That's correct. 

> Prior to the changes in this patchset, and assuming an nbcon console
iMX swtched over to nbcon, so your assumption is correct.

> (which may not be your usecase, but is perhaps representative of
> future use-cases), then the printk delay will always happen within the
> call to printk (and always before emitting).
Which is quite good, but can be better. (See the missing sync feature
mentioned in Johns reply)

> However, depending on the context, that printk call may return (and
> proceed to your CPU halting register read), before the message is
> actually emitted to the console. I.e. it's a race.
I am aware of that.

> This series moves the delay to the emit side, as well as moving the
> delay after the emit. Thus the calling code may make progress more
> quickly, but depending on the context, it may also flush/emit before
> returning from printk.
Unfortunately it makes things worse.

> In my view, with or without this series, there are no guarantees that
> you will see 'A' and 'B'. And in any case, achieving the functionality
> for debugging required you to modify the printk anyway.
The "sync" feature is on the TODO list as John mentioned. 

> > So please leave the delay on the calling side - it is helpfull
> > there.
> 
> If you want to ensure printk is synchronous, perhaps you could call
> nbcon_cpu_emergency_enter() prior to your printk, or perhaps there are
> already printk wrappers that do somthing similar whilst debugging?
As said I did an ugly hack and forced printk() to be synchronous.

> Would that provide a more reliable way to guarantee output?
It does.

Regards
    Benedikt Spranger
