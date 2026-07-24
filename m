Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CFC36923F
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jul 2026 21:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929039; cv=none; b=Wm7SMlr/hYe5LJDfW+TpD7pZq7H1BHNMCnAD+oM6y5KhtyKCQKJL0SxeqISF2NzjQcRCO7ZLCaBcPU3vP8lt1Pw1JF5lz5wjCFmiBnOHpuHVxE+actdZizg2jMz23+uWQmF43apX1we58GrqNtoqG7UqxFtRwdjWfiqfK0PC18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929039; c=relaxed/simple;
	bh=rXmESC+ogzRUoBCqexa0HRaaPKIP/aORjommBvUq5SU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hHxyVif8ExfFvXvTQMPc6AmD2/9tWiREZVERE+rA11jav2w2IzPktFVm9Db2WPvzWMzeNqxjhNvuklkN8sPPsG85ftrN+bsUqcNbTbaQyvBxoa5pr/E8xf0tra2MqLPFsYEfSKnM6bUlLeBLvXkwMG0kncEVjP0qpdcIf7V6mL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmQbqgud; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmQbqgud"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso607294f8f.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jul 2026 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784929036; x=1785533836; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nuZr0SzwEmaEHP8VYIwWfef2g2YTiEiEHZ6M99Shj8M=;
        b=DmQbqgudf+pXD3xAAwPRhnH+ZtUqQdaEWb6bSXzxybq63izjE+4o7KDsDN1zBmm1SS
         irIwFZVfmHnCbmAbGJlZ+3Z6u+ScexUSojo0X+qB/TUHe/fi3B1n8fxgu4mIq/UvTG9G
         nptZidcBaO04fXpFDUxA4fv/Mvvl1dLmB/1S/YyaSUiQQB9gr9iEeK7cHveHx09Fsos0
         Bp3JV8ceQIhLsYmM0PDGUaQqokc9XOp3O66Jl38vwlGg+8As4hxWRKXQlJYFQ/FTxPAB
         knM49PW/7npXL1ecizfpVLvtjmAmEwkObeXsApIM7n+mXFu+C+xPd+628bRbKQr1xeJf
         q4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784929036; x=1785533836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nuZr0SzwEmaEHP8VYIwWfef2g2YTiEiEHZ6M99Shj8M=;
        b=tKPmnk6kczVR4sHg1y4EM0McSkX7J6jSpz1nVXnrc2Rb0pp8iQRdl/qox9/skuFl1i
         kPibEGX5+mCqYBsJSb6nOHT+OJ72u9HSgRmMORkjcCepztEHBSjsbMTsvpxYXsvUrpKh
         hsdNW+4kdl5nQZTBRdg+rf0Jp+aRjsRKH8so70tLRfDbG85TdHKBkczodLa3yL8Mpcpd
         rRlW30OJ+9WKVhURVQDg5Xn3K2HoaX3MDsttFlPHMv1jfkUBfvi8sBw8gzvdaTzcd5jG
         orNrPcr50LI54tt14TIjHDpqeX45W/MJITT7migJfZads4xgIxqykAWdHVh9MFh0fCnu
         aVDA==
X-Forwarded-Encrypted: i=1; AHgh+RpDBPCXIk7stFDM19fGnnfbUsqVdHe/Unx0UVJc8F/3N7kKuDDn1q/KQawrIVyc/ArkJyePDf2i5rQoeJEIrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCfi0P3l8yJmZivCgZg6ynD1wuE702tdKMYG0Y5ompx1ALU9kQ
	fh6aYE7rzXDDgtvpHAEgHF9v0qi1BHnsi7VnWyrxUqyHWAk4mT5gg8GL
X-Gm-Gg: AR+sD12PXrBBUgU97RmLu6iRU4P/h7/bZF3GpN2vjv37fzlffvJo7jRXDLkTdaDNqLu
	QXXeY31Z1P2e5R+Wp19xQqLQL5+hRAr9M7cX4DPeXllQA+gM2ggL/Ic9YvG0TqAdrqsxKtA2QIW
	ny4+9Xc88Cb/U/oOPz9ROENxXqzFIvehxxSPjJ/pC0AYL6iCkGqNQ5K4deBoITWONf+LtR5aTv0
	gwoaVpFMh5QQFlEBwZOeNZFIVawV6Ax4AePHp7lsAy3rkf0Pa+3O1fi1XIhgFgZqKirTKN/uvBC
	ji7ktmw61DQshf+Cr9f0I3M1LOPMsdB6jhlqp4AoPn5ThfdrM5Dy5ePAGPoesOdndADwbii63G6
	+hYHxZmMAtw9P1liM+4oTmkGmsRD/+/X8hKuqcChVOr5z/o1+1+bxFt49orulYopWKCqFdyFCtI
	ge2OIqesvyxu4Xts0+YPkbXDH+B+BA6/dWsQFvlNXl+b0iY9hm4fOy1peawIe/9SfdSTVyqkOBI
	RjSR5KYxBvWtYfQpHqvTfzqn8hlCzNd1G2POQ+fHshA9N783j91oBvx0SbcvRdIPX+hxO8wPYZ+
	aRD5GHgokKMM6HUb0phQZc6S
X-Received: by 2002:a05:600c:46cc:b0:495:5e86:4e11 with SMTP id 5b1f17b1804b1-496b57177d7mr363715e9.12.1784929036022;
        Fri, 24 Jul 2026 14:37:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae93-f301-cdd9-d5ea-080d-9131.310.pool.telefonica.de. [2a02:3100:ae93:f301:cdd9:d5ea:80d:9131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499cc49sm20754015e9.9.2026.07.24.14.37.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 14:37:15 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
Subject: [PATCH v2 1/2] serial: amba-pl011: unprepare console clock on unregister
Date: Fri, 24 Jul 2026 23:33:47 +0200
Message-Id: <20260724213348.77418-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260724213348.77418-1-kmehltretter@gmail.com>
References: <20260724213348.77418-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pl011_console_setup() calls clk_prepare() on the UART clock, but the
console provides no matching teardown, so the clock is never unprepared
when the console is unregistered -- via the sysfs "console" attribute or
a driver unbind. Each re-registration prepares the clock again, leaking
one prepare reference per cycle.

Even where preparing the clock has no hardware effect, the stale
reference leaves the clock framework's prepare count unbalanced. For
providers with prepare/unprepare operations or runtime-PM integration,
it may also retain resources after the console is unregistered.

Add a console .exit() callback that clk_unprepare()s the clock,
balancing the clk_prepare() in pl011_console_setup().

Fixes: 4b4851c65d92 ("clk: amba-pl011: convert to clk_prepare()/clk_unprepare()")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8ed91e1da22b..1aa43994a3cd 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2552,6 +2552,15 @@ static int pl011_console_setup(struct console *co, char *options)
 	return uart_set_options(&uap->port, co, baud, parity, bits, flow);
 }
 
+static int pl011_console_exit(struct console *co)
+{
+	struct uart_amba_port *uap = amba_ports[co->index];
+
+	clk_unprepare(uap->clk);
+
+	return 0;
+}
+
 /**
  *	pl011_console_match - non-standard console matching
  *	@co:	  registering console
@@ -2705,6 +2714,7 @@ static struct console amba_console = {
 	.name		= "ttyAMA",
 	.device		= uart_console_device,
 	.setup		= pl011_console_setup,
+	.exit		= pl011_console_exit,
 	.match		= pl011_console_match,
 	.write_atomic	= pl011_console_write_atomic,
 	.write_thread	= pl011_console_write_thread,
-- 
2.53.0

