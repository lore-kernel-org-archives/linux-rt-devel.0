Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E041F4180
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Jun 2026 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780361061; cv=none; b=FvSINkYqtoc1i+KzprTqJoTgF4BBuaYlzuBnjIhigGV8ePUjCO5QJM6bkiSkUMIl6tZyjybO5naEcobw0DAsn3tmSA1b7AF0xyeb8B+kPQ1R7UV+gt0HM8G1MQ8Ky99W/pSx4cZyW+/fONS0AXo7OViJ32ToSh7XnNqQgDqH0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780361061; c=relaxed/simple;
	bh=xgJ7V0ENrBO7HnCYHHPTG2icvZb7IjbyLhkxgYZBUkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmMCMSCjEDDwDniTyRLjq/ecJBoKzz0KWA5mo4oMROyGYLlmB8hwrc/qsvXE1to5o/TW6r23fYgQj8+iIBJQS7vWgQK2z5p2TUK+BmGBj0aqYTAzpLwkPnEIMXlf/6Rya90IyYx9syQZqBIITh9FBTLPg3IUsYAh+gnQffeB7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=CTeRykPW; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="CTeRykPW"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-304ddfcf72cso4730230eec.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 01 Jun 2026 17:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1780361058; x=1780965858; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YU4nTV8pXfPQduF2ie+x5BszKiRZNCF/8yTRq9PVrAA=;
        b=CTeRykPWhqsXpcOeXxGKyHbP9YSq96OZLsytUYizYwf2s9Qfv5d1U+pOK8ZTCc00xn
         dUl0PIaFyE14bYeaKjOx8KIuRVo2NJcSiTSOFRlGDwDz+hXoJlPasYjO4ey3B3L1KWgB
         ZxcMkcJJFqRjRqzMCpgwCNIS9CAs4oJKe3wxUWMM9pjyDPdcRc+NRjbcvrUwR0QNl8b6
         NXEvDWDGPfAYvLvE0D3qZale43nmzNU99K/PnXJsIFOB+0ZzlargB2QvNjJHx8+QXP1E
         9jjPLMs5wqLjm+zeKbNFDezSCvA3IQHdekn8YDVqu9m8wK5vcrAO0a6vf2NoKtguH1n5
         cW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780361058; x=1780965858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU4nTV8pXfPQduF2ie+x5BszKiRZNCF/8yTRq9PVrAA=;
        b=TIrtOyrEkS/+uHbfJ8URNWRj2MavleuTtFJuf0yCNZq+/naBebyfdVFF31JayMzYTW
         frcAUWuaGB7KZYQAV62zZZb02E5ewQvXRbszRxPxIc3V9bGa68U3SOoiI5KbyJ/cSEvi
         9ifCT0yHHx0PdM+Mn0D2z3ah7UNXcoO7JcTjJ+8voDr/Igbq7IJrle6i8H0NElkUAtlr
         OS0vc9bW1gclJmFlK/Pud1cT8itL3Zqh5CfTL+4HU6iF8POwsGLTfYXJVQAErpWaek9X
         Ja9S8m3iPUsP9e1JHXALkYh4z/PwbPKStIogBb+QrEwHQl8nJ2nfshx3tAi/hhET7Dbt
         7EYw==
X-Gm-Message-State: AOJu0Yy2augfFc5mTTzR71gawKLRLHVI/UNtOpy+vgARW+o5CTanVu+P
	HKkcpsRsq4qAswIXi5r+lDZiws4/87G8sx1v6NHmZ3KqDYz0mrrNi8bBvWAsJgDyqcQ=
X-Gm-Gg: Acq92OFNBcXF2X97+sdbi2XVrza9AlvUqaMYWmjzijoepRcNoYABdjQz9IM43cusCMg
	gAeQbUdjaeNPFNUWR+N42FLRKHf5bddCf2h0CSM8ctnmWPEbDzEQ/OI/AORf2v4BrlupWEZjs3E
	YnvCfJWEm2fO6O350nd3qNBLwTdK4tf4h0YcNXfP86IHlIeZESfXmkJ4IjisQqJSKQd0riNW8bb
	gNFDBmoPE9fbpsgCe/ZZIxyvRhLzXO/dKI5GF+ATcSSmm5NrnooBnbU8TOwNkmBLbkHxxELVwqN
	CD2ivBQ4qAyj7wA+mNnvZDlShlgc0VvIH12FQ9El3A+pSXY7lXkmt/MxiO3dd6452xEfgKKAg0f
	eTAqn9lkyqNYKM5E1krq+l3f+o35KKxIW2oAeDuoNfqtSw9of+BCepHf2OY9KN8porwKjVmYt9U
	aQrfJHdzIybly6GFMF+Mb7AQsVsBzQO8uhrlkE
X-Received: by 2002:a05:7301:1f06:b0:304:8881:b82 with SMTP id 5a478bee46e88-304fa4cf1fdmr6379022eec.1.1780361058228;
        Mon, 01 Jun 2026 17:44:18 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:e55d:f6f2:1f67:2056])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c10c1sm9892762eec.1.2026.06.01.17.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 17:44:17 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Rodolfo Giometti <giometti@enneenne.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eliav Farber <farbere@amazon.com>,
	Michael Byczkowski <by@by-online.de>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH v7 0/1] pps: improve PREEMPT_RT performance
Date: Mon,  1 Jun 2026 17:44:08 -0700
Message-ID: <cover.1780359378.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

I'm relaying v7 for Michael.

A quick note, this conflicts with the patch I have out to remove
capture_clear: it's trivial to resolve, but if it saves anybody time let
me know and I can respin one or the other.

Thanks,
Calvin

---
From: Michael Byczkowski <by@by-online.de>

Changes since v6: https://lore.kernel.org/lkml/cover.1779733602.git.calvin@wbinvd.org/
 - patches 2 and 3 are dropped since neither lock is ever taken in
   hardirq context.

Changes since v5: https://lore.kernel.org/lkml/719A31CE-CA58-45C3-A013-1BFE81F724C5@by-online.de/
 - Reordered: the pps_kc_hardpps_lock conversion now precedes the
   pps_device.lock conversion. The previous order would have briefly
   produced a raw_spinlock holding a sleeping spinlock on PREEMPT_RT
   (Sebastian).
 - Patch 1/3: commit message reworded to describe the handler split
   structurally first, then its PREEMPT_RT benefit (Sebastian).
 - Patch 2/3: refactored pps_kc_bind() and pps_kc_remove() to use
   guard(raw_spinlock_irq) for scope-based lock release. Eliminates
   four duplicated unlock call sites in pps_kc_bind() and the
   ambiguous bracket structure that resulted from them (Sebastian).
 - Rodolfo's Acked-by on patch 2/3 is preserved from v5; the guard()
   refactor is purely stylistic and was suggested by Sebastian, but
   please re-ack or NAK if disagreement.

Changes since v4: https://lore.kernel.org/lkml/B24484C5-3117-4C56-9522-1EE9876E64BA@by-online.de/
 - Patch 2/3: added Acked-by: Rodolfo Giometti <giometti@enneenne.com>

Changes since v3: https://lore.kernel.org/lkml/83318241-44C3-48BE-829D-5C5F82A78A74@by-online.de/
 - Patch 2/3: fixed lost indentation on pps_kc_event() call
   (reported by Rodolfo Giometti <giometti@enneenne.com>)

Changes since v2: https://lore.kernel.org/lkml/1BB87C0C-33C1-45C3-B50E-C5F349DA3FDC@by-online.de/
 - Patch 2/3: moved wake_up_interruptible_all() and kill_fasync() out
   of raw_spinlock section to avoid sleeping-in-atomic on PREEMPT_RT
   (reported by Nikolaus Buchwitz <nb@buchwitz.com>)

This patchset addresses three sources of PPS jitter under PREEMPT_RT,
while being fully backward-compatible with non-RT kernels:

1. pps-gpio: The IRQ handler is force-threaded on PREEMPT_RT, so the
   PPS timestamp is captured after scheduling delay rather than at
   interrupt entry. Fix: split into a hardirq primary handler
   (captures timestamp only) and a threaded handler (processes the
   event).

Tested on a Raspberry Pi 5 running 7.0.1 and 7.1-rc PREEMPT_RT kernels.
On non-RT kernels there is zero behavioral change.

Michael Byczkowski (1):
  pps: pps-gpio: split IRQ handler into hardirq timestamper + threaded
    handler

 drivers/pps/clients/pps-gpio.c | 37 +++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 12 deletions(-)

-- 
2.47.3
