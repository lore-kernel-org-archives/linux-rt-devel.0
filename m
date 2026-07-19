Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8E2377A95
	for <linux-rt-devel@lists.linux.dev>; Sun, 19 Jul 2026 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784442998; cv=none; b=jYQEvTIAS9cAXEJDhZsngWw4FktajYCctJv4AEYRKmZJ71xoZ3K/GGFhHIuzhfEpdnzNWZv9Lcib6t+bCR94du+PUFqWH+w4dCjZUGYSnPSljssEVgZ0Y8JHzBprnw4w/9TtrL61pStbBzQ8vpTgy8s3NgERBCLUwAJqbjg/C3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784442998; c=relaxed/simple;
	bh=mkB3xIZNgBskQ9evx5tewNXRxL4ZNzszLj6LDriEggI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AvWJOT0tDg5sKkhVGA4RfFSw10qGyiaZ/z2XdtIZecpXQ+qNsHgBfbg2rphcGgMqm7dBZFrCp7rUNsTmgz9REUoVdN2fz8O/zl9L1OTjHPpPDtt45ZtFM1DkpPtoE7trF+zX+u5D43QmzLXZdnH5g7e8QSL0Kxn9sy6ri8EUkTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G720lcBU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G720lcBU"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-472326ca506so7046961f8f.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 18 Jul 2026 23:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784442995; x=1785047795; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v/s1B1a6XBIG/yN44lOc/BilNlkIq0umJ5mItLmYXAU=;
        b=G720lcBUgjAogI40NLKG4tX/XPqe9vDEf/ETSh96GWNdAL+QXwEZROw7sFEOqjFs7g
         Xf5jPAdvFxpqVEiBaG0GmUmV0xO9OX+sLts0OyOFm9JixGq9gXryeUUl2CGi2NBI9ZoY
         lQxb5WpXkLqn0J47Squ7LTh6s0kZWNokXJCs74q/IOmZ+I+8PrnOU1eGA7GPeqBet1Pf
         dyVIVP2iAXawsCpF5IeKiKOsi+MNPvGqhJki19CMAOEQGWZ4b1qTlCa28oAw4cAH57Z8
         kKpOcTP7So6u1Ya6fvGHmN10FaIzQ1j50kH0QJ8s797HijidmNrbga0qAhTMtyH9Yp6Z
         oXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784442995; x=1785047795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/s1B1a6XBIG/yN44lOc/BilNlkIq0umJ5mItLmYXAU=;
        b=Bd2UdDFNdbnHw3Y4CfPfHd5hbDDRRi6RXsWsBzZzEZlO6oJGBl9lla/B5wNKUbVuOJ
         QXdnZDH1bWyl9RLiCNRBEsGtO6RRsZmEm2+vi0TEiZo0WWac4+yaWqH2xbzgwQFWW0f1
         pQ9fCgMSLGbBQqnJ6+DtzsVSKQ3+02x2HBZ7qTjJcspqvTGaYh4WbvG1bN5SlVpSWpOv
         qeYNHECC4rS/MIHe86ohRTbv/Gj7m2P6jEa+275I9/zA+OO4ePngHJ/b5nhWHQcXYPgz
         rDnCO5XNNjkglPK6f7VJMA5xevCrdhNrHgtjlKnlafQPe1OTuwYFPsSg9345OC2a8ZP5
         66iQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1jQR9wPQPwIDSMgxQMOH7M5T0nwkWrR83zkjK6hcjiRpIrRtinBnbzhh7409ckGmQDaAYGE0QquzGoIYpaw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yytd5GINMDuK24wFmFjuDrWq406+Ghe98QYHbfZX/eFmE95MGKP
	QfeTkjK+Z/GU3Sl3Yj5mcE1TOUsIbkDdwf8iQsn7lPpiLrIYSoerZdzQ
X-Gm-Gg: AfdE7cnNA8sCcUbPDTcLM1YYd+j80RbCsTwj66rEL6d146j5en3CgDPv2HOm/WZ5yue
	69tEMuPgbWBoO1Mv6of3G9bpiIRifS3vySGbDTpf6nXbiXcr+KYYc8pSWj68ngnnuU2IVujlrGy
	/bD9m6/q4fCcWIQf+IKN9S2wUJCI8IXsUy8JJZXDWQU66QBS8yKBdgZynK2j8xuG9KUQtWi8hcv
	2DshO2QppGh/puaeTTWJlLwg1RuQ+isBoQRMfBd1A5FO5ENZz6RtKy1nJ+4fO2nqA2hQa4ExqxN
	HQZRurOPwTgWLhJZoScGzwXIZeOKLJn5egFD0sxtIh0yjy7onD3v2tyvHvBuIYFZM1xGtrjDyZu
	haWYYH9xdBbewQvIRvPgMn3nlL108xXfUdH0aETx8PXto2MJ+E8ONaH9dW8F2ZYc6Ml8f/a/0uW
	nwDUi2IO+GOJbBruxGRn+V0MftdwP419nKRi/6+fxmC+UgUpwm5CpC2blMtzlRMQfCmlRUWWF9L
	r78w2ug2AdJDdl9awgWcPOR77JGFqvYL4VxiYc=
X-Received: by 2002:a05:600c:26d4:b0:495:4075:7dfa with SMTP id 5b1f17b1804b1-4954a51e4abmr62580465e9.35.1784442994501;
        Sat, 18 Jul 2026 23:36:34 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-018-194.77.7.pool.telefonica.de. [77.7.18.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96f19sm193053245e9.9.2026.07.18.23.36.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 23:36:34 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 2/2] serial: amba-pl011: keep console clock enabled for atomic writes
Date: Sun, 19 Jul 2026 08:35:02 +0200
Message-Id: <20260719063502.18852-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719063502.18852-1-kmehltretter@gmail.com>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pl011_console_write_atomic() runs from nbcon atomic context, where
sleeping is not allowed. It calls clk_enable(), which takes the
common-clk enable_lock. Under PREEMPT_RT that is a sleeping lock:
clk_enable_lock() first tries spin_trylock_irqsave(), but on contention
falls back to spin_lock_irqsave(), so an atomic-context printk on an RT
kernel with a clk-backed pl011 can trip:

  BUG: sleeping function called from invalid context at spinlock_rt.c:48
    __might_resched from rt_spin_lock
    rt_spin_lock from clk_enable_lock
    clk_enable_lock from clk_enable
    clk_enable from pl011_console_write_atomic
    ... from vprintk_emit

This was found and reproduced on 32-bit ARM with PREEMPT_RT. In
addition, write_atomic() may be invoked from NMI context and is
documented to avoid locking. Since clk_enable() acquires the
common-clock enable_lock, removing it from the callback also avoids a
potentially unsafe NMI lock acquisition.

An nbcon atomic-capable console must be printable from any context, so
the clock cannot be gated between writes. Enable the clock while the
console is registered: use clk_prepare_enable() in
pl011_console_setup(), release it via clk_disable_unprepare() in the
console .exit() callback, and drop the per-write
clk_enable()/clk_disable() pairs from write_atomic() and
write_thread().

Keeping UARTCLK enabled may increase idle power on platforms where it
would otherwise be gated between console writes.

Fixes: 2eb2608618ce ("serial: amba-pl011: Implement nbcon console")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
The PREEMPT_RT splat above was reproduced on 32-bit ARM (versatilepb,
ARM926EJ-S / ARMv5TE), Linux 7.2.0-rc3 based, CONFIG_PREEMPT_RT=y
CONFIG_HZ=1000, by driving an atomic-context printk; with this patch the
clk_enable() -> rt_spin_lock() splat is gone.

Tested on QEMU raspi (bcm2835, gateable CPRMAN UART clock) with the full
series applied: recycling the console via /sys/class/tty/ttyAMA0/console
keeps both prepare_count and enable_count balanced (2/2 across six
cycles), and console output resumes after each re-registration.
Suspend/resume was not exercised (no platform suspend under the QEMU
model).

 drivers/tty/serial/amba-pl011.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 1aa43994a3cd..4facd1b350d5 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2523,7 +2523,11 @@ static int pl011_console_setup(struct console *co, char *options)
 	/* Allow pins to be muxed in and configured */
 	pinctrl_pm_select_default_state(uap->port.dev);
 
-	ret = clk_prepare(uap->clk);
+	/*
+	 * Keep the clock enabled while registered because write_atomic() may
+	 * run in NMI context and must not acquire the clock framework lock.
+	 */
+	ret = clk_prepare_enable(uap->clk);
 	if (ret)
 		return ret;
 
@@ -2556,7 +2560,7 @@ static int pl011_console_exit(struct console *co)
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
 
-	clk_unprepare(uap->clk);
+	clk_disable_unprepare(uap->clk);
 
 	return 0;
 }
@@ -2630,8 +2634,6 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 	if (!nbcon_enter_unsafe(wctxt))
 		return;
 
-	clk_enable(uap->clk);
-
 	if (!uap->vendor->always_enabled) {
 		old_cr = pl011_read(uap, REG_CR);
 		pl011_write((old_cr & ~UART011_CR_CTSEN) | (UART01x_CR_UARTEN | UART011_CR_TXE),
@@ -2648,8 +2650,6 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
 
-	clk_disable(uap->clk);
-
 	nbcon_exit_unsafe(wctxt);
 }
 
@@ -2662,8 +2662,6 @@ pl011_console_write_thread(struct console *co, struct nbcon_write_context *wctxt
 	if (!nbcon_enter_unsafe(wctxt))
 		return;
 
-	clk_enable(uap->clk);
-
 	if (!uap->vendor->always_enabled) {
 		old_cr = pl011_read(uap, REG_CR);
 		pl011_write((old_cr & ~UART011_CR_CTSEN) | (UART01x_CR_UARTEN | UART011_CR_TXE),
@@ -2692,8 +2690,6 @@ pl011_console_write_thread(struct console *co, struct nbcon_write_context *wctxt
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
 
-	clk_disable(uap->clk);
-
 	nbcon_exit_unsafe(wctxt);
 }
 
-- 
2.53.0
