Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77D3F39EA
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jul 2026 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784928848; cv=none; b=GTAEloQLgEQAxBe5te8pXqlnMpsEAOc/gIOh9jBVSqXyrlOkIGO8GKDqf31YHbgwrESBo3UE/q7UzTNUZR0T3VmjGTkU5U7OdaXCuJJUai75kjGuyACDrsrPqGncQoyVDzE1u2eHKmd3Uvl/qSuY/FpDcNwRbIMiTmnSbsg4hR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784928848; c=relaxed/simple;
	bh=L8/5qgDEjoP17OJ0HMJ/A3XES9LvHVdVUJiHHaCp36M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g+zhL4frRzTlRbD+kv/QJbVPAywnuPjv1AY4o1VX48oEYzcfyVpxZty3D24rpf7TdQ1UVHUQGna2ozcZSUhEbl6eQkKWZaTitwdi/vje7RAcLGCCOrbacP3coiVXmUg4nNtb+yv92zc3C6qlkYAYO+aaI9iY7lxaPQvRSuXEJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt19PjvV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt19PjvV"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954dff6536so6426235e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jul 2026 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784928844; x=1785533644; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WOnGh4nCACqtC0cvfPaQrFlO41pTulyeZNkgwFh3MsI=;
        b=Lt19PjvVmS/x54F9LAyOEG2VfhlbLGMSZDLjyupGxjRF0TuHlzAu5JPD3bBh8O1M7l
         bnUpbyPXvmfXp6CXpjj4NXgZu1HhN/6pgZm4jemgt51Hj6YZq/4NeFSQfYsOs1mwtALU
         jj2fDCZ4TxqmdQmPVQbAKiBrYtFppegTsNfGOTkryaGRE5WoP36no06X8p4IJWpYintY
         Ls7gD6N1k7LyzjpwV7VE1tdw0fk0dQO9IWpunkiQ3Xm1PJlBiSfQAfroigS6IlL1FeDQ
         ME0oC3VAxwVSaXU+SF++AMNQdekn3SK7iqofdZddRTeeqRCEoCWQjgpbzg9mMqKW8R9u
         akFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784928844; x=1785533644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WOnGh4nCACqtC0cvfPaQrFlO41pTulyeZNkgwFh3MsI=;
        b=HCUtz73tw4bs+3QsaWTmFudT9sbtyA18uQAfj3idpr5PmtfSfnhhmwdvt9LEXlXen1
         ytrfVJERX0lGXLgSfW9x+WY0S9LozjLwf20tE3QaGb2ITGjxrOAUKEMC8KZKtOZ5PLob
         8ooTbIYeke/mbbl17hh452Wf8CVUmfrjafQ1ElBnMtXkYhE4lLt8Sn7BrrqqdZSCz7HA
         ry1yfPdGoY+keFQdAb/OQpnVG9j+dp2lfm5W8xuZao/p4ywfOWLm9O4CUKUaxHV0sjYe
         aFzjrD9Ul6AeUZw84SWTPUXVMwBvy9KI/2T5GbyRFLKxQ5ZqlZ5wol+gRx//Yl6NYQm4
         uEUA==
X-Forwarded-Encrypted: i=1; AHgh+RqPT+Gn0gtNNdswTwhVv6UNLdqi/tZISBk0M7asDX01ilJH3wgbQSiaoaiQvZ/wYAi8gw1BPOCrZLLYZjr7/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGg9M64qM/4qJo0fqQZS+stgTzSJtBaD1pNC9HhuHkqXCJwCcG
	3Baar+CuH+OcY+K+UHuB+ztFRjhBtdaCUdHYKSsVGAiXnE5KYtRU68F3
X-Gm-Gg: AR+sD134VVLM0sKg8p+Y3QDGUF0q32ZJ9Ax4sgW9/ofVsncLXqbU7ETAf0W4X4zfAmV
	919kk4DFj6qkTF5vdj4f1r4qeDztRy4HkyPiJsdzWS7eF8paBuLTqJ5fvBQfUDX81mtmxsBFtd2
	CWlW/oFAUk36dHan47527XENPa51e/Fmw5g26LTVZzTKh0njsxESiA2B5tRwwtnmixycjtaJOAi
	Vm6GVXQ/Rlu0Ua6I9AP12Iay1FyoEPg/KY6K9biZbC3XxRsK0G5db/fEx3yJVNQeCMDiIiZyG8Q
	rSJXwaPJTw1DNI2B6IDfYbSgRk2G+haToyAc5Mm5ctgCc75mJ6AmN3/tN/tsGaOQ4baalA4RlOY
	GZBpIBl1TnSwkxvqkXckL+ZcgC47thIAtG7AIHZTtKHXPfrFfd/SntlVL8+v6YH+2rcqpnDkXr9
	rY92vBcL6JVD4wudp4+ZCeNSnLJp0Y4fL8lO8MfAjy3QS/KQgUMBftSv4Mn8RtCHK1eeeJNSfLh
	IONZAwXVW0IQUi4ATuTR5GxFg8Pc5uRaARy8zF42WyqqhvJylm97BOkdgZ4wJIv8CQI3i2hKVqq
	vP0x5o75pbmV9g==
X-Received: by 2002:a05:600c:870c:b0:493:f7c8:eae2 with SMTP id 5b1f17b1804b1-496b56f9749mr527725e9.15.1784928844090;
        Fri, 24 Jul 2026 14:34:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae93-f301-cdd9-d5ea-080d-9131.310.pool.telefonica.de. [2a02:3100:ae93:f301:cdd9:d5ea:80d:9131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499cc49sm20754015e9.9.2026.07.24.14.34.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 14:34:03 -0700 (PDT)
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
Subject: [PATCH v2 0/2] serial: amba-pl011: fix console clock lifetime
Date: Fri, 24 Jul 2026 23:33:46 +0200
Message-Id: <20260724213348.77418-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes an independent bug: pl011_console_setup() prepares the UART
clock but nothing releases it when the console is unregistered, so the
clock's prepare count leaks one reference per unregister. It adds the
missing console .exit() and stands on its own.

Patch 2 fixes a PREEMPT_RT failure: pl011_console_write_atomic() runs in
nbcon atomic context but calls clk_enable(), which under RT can acquire a
sleeping lock. It keeps the clock enabled while the console is available
for output and releases it in .exit(); it depends on patch 1.

Changes in v2:
- Add suspend/resume management for the persistent clock reference.
- Keep the reference for no_console_suspend and RX-wakeup ports.
- Document the platform-dependent power impact.

Patch 1 is unchanged.

Tested in QEMU on raspi1ap, raspi2b, and RealView ARMv6 SMP, and on arm64
virt under PREEMPT_RT. Actual s2idle suspend/resume (RTC-wake) dropped and
restored the PL011 clock reference, balanced across repeated cycles, while
wake-capable and no_console_suspend cases kept it enabled. Strict clock
checking found no access while stopped, and RX behaved as expected.
Toggling /sys/class/tty/ttyAMA0/console showed the prepare-count leak
without patch 1 and a balanced count with it.

Full-platform-sleep and actual RX-wakeup were not exercised.

Karl Mehltretter (2):
  serial: amba-pl011: unprepare console clock on unregister
  serial: amba-pl011: keep console clock enabled for atomic writes

 drivers/tty/serial/amba-pl011.c | 53 ++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 11 deletions(-)

-- 
2.53.0
