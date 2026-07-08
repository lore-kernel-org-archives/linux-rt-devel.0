Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F53B6368
	for <linux-rt-devel@lists.linux.dev>; Wed,  8 Jul 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506996; cv=none; b=qvvcnx5DR82let6OxecGZb002th0a+ErXydCDGt1pJ9Qz/2z/m1b6BY/OIgNKpGV2fvktt5tZZr+JSlFQULoF2tLbuycR0rKa3fBLH4WpXPUs6kLUQMZt7d+tU4+vj3l2W0lSRY0lMxxCZfYx7ip1iq0RHMuIuzWpJ5XTcvDdk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506996; c=relaxed/simple;
	bh=CptA4H/0yTvtYAkCQi2Kx0njcJk4uT/iLYE9SPVIZgM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LQyau1r/i/inWIMo9uJOMzXmBREWd+Tvu0h3dWrYn3ndoCjynAdQNXcbXyCfXt0GIXfxPpG08PiXWjPZc9enBuvn9KyAvMawRpjDR0X8spAAEyAUi6YRGdlEGCeusVhqI2R3KI1qvcy/ZTyoG0QiP6JkZVYbDQ019/qCIYtGoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gb3HtCoK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fRArbuaP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gb3HtCoK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fRArbuaP"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783506983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4oSZ0VvgFHGlDOd8o6hkiwFx03nfgdvtHM1XfLEEIwY=;
	b=Gb3HtCoKx6JK0GUWAyn+2ejS0xH2woEWxw3+K/nj2+wIJBR7fWvEPMFvFkyMvlwrSHvH3y
	eYqC9WH6f0zAbTbuXVSWvtLBe4ST35ka3Sx3qaoz/My1koLC2UrFc5rGvE+V0VwrOd6njF
	/6QPl/3E393XAhbRW6KoVsP/8FRAxYG9XY/ou3u5uSQQnxhnOp9j85d7VB+TGEBiacExE3
	xJRbPhjE0DAIxiNex0yDdcKTec11EZmdD/YpK0wBUMeLP0I3e2YCMqu/Pyf5yPUyWPHO70
	yB/zK+5LOoE4/L0SthgVe+xva8k3B7NyCM772BL/6skjkpHuTGfdHgW9SEka3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783506983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4oSZ0VvgFHGlDOd8o6hkiwFx03nfgdvtHM1XfLEEIwY=;
	b=fRArbuaPMd9AD20Wgcx6lGklXPR5RU5QhFZJ34To/S8oQ81VuWWkxh+y3qq05R2rkX18yj
	OVN5nvYiWZtrpKCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Russell King
 <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Steven Rostedt
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
In-Reply-To: <ak0b2S9jjYy49a8V@pathway.suse.cz>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
 <87zf08w7qo.fsf@jogness.linutronix.de> <ak0b2S9jjYy49a8V@pathway.suse.cz>
Date: Wed, 08 Jul 2026 12:42:22 +0206
Message-ID: <87echdvkd5.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-07, Petr Mladek <pmladek@suse.com> wrote:
>> This is too deep (also pointed out by Sashiko) because it multiplies the
>> delay times the number of consoles. For the legacy printing, it would be
>> more appropriate to put the delay inside console_flush_all() and
>> legacy_kthread_func().
>
> True. The question is if the proper solution is worth the complexity.
> We would need to pass the information down two level of the API.
> It would require adding a new (output) parameter to console_flush_one_record(),
> nbcon_legacy_emit_next_record(), and console_emit_next_record().
>
> It is not that complicated but these functions are already hairy
> enough so we should be careful.

Fair enough. But then it should be consistent and
console_emit_next_record() should perform the delay before allowing the
handover. Something like this:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2fe9a963c823a..62fd6a5ebef66 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3161,6 +3161,8 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 		 */
 
 		con->write(con, outbuf, pmsg.outbuf_len);
+		printk_delay(false);
+
 		con->seq = pmsg.seq + 1;
 	} else {
 		/*
@@ -3182,6 +3184,7 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 		printk_legacy_allow_spinlock_enter();
 		con->write(con, outbuf, pmsg.outbuf_len);
 		printk_legacy_allow_spinlock_exit();
+		printk_delay(true);
 
 		start_critical_timings();
 

John
