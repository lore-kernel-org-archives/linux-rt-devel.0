Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E032E128
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137507; cv=none; b=kE3ac7eO49MMHm6/VXQC61n2okNNdagwNyb+Wkh8nJ9Mu8L7SO2OCNoWbzQG9vUedd7zFvuVMMDiS9uzckVSOXOht7ZX+AQi5M21uCMJwLGq4pmEUi0KMte8YTT0DM+4r7EhOCcAQKLJA7ibtkoUjJKQKmIZXjg+fE06lIqXIfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137507; c=relaxed/simple;
	bh=9UJFyZ/yDghIK+87yVI/6Ni4aMm90o+d2/LvTvtEHa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bqu6a/8QvZPNAH2pCPW/5njkaRAWudTRh+lUnmIAUMZ24+P228hH+ksUoDbYVlshqEeFHYgdPsFQy2TNZdUwc54npAVbTNeEoVNrvDHSkm4IpYZ0x99mm1m5zT6HJH2w3L8CLOzLoQn2DIXhjiKev9FjnLO35MR70+ewhit3cM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tQIYHmZe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yjAdc7I5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tQIYHmZe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yjAdc7I5"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789137501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N6PaIRR6vaepl3eIq3aZZKgYxRKsTTVY7PDJr2bCpPY=;
	b=tQIYHmZeeN9/8Vb8iaoo/KCuWoQ1bVs+S70OB1NyV+81/IKkIYHQmDKHuwd5xo6UlLq0lI
	NzbKoSMwYGY3JI9u4T+hJlLkDnkhw321G203pflxI5N0tx/rB+Zks0Ck/oSQRd8TOFGgm0
	dnC/elr+zIIzx6fpaHZTlF2IOlqV0vg63KpEvzjik71lUk7o+Rn/6lRtOwfJLkzwiDQLQe
	buuv1aQQfl6NIt0B8yXwmZAq5tVHapl8uwbArLzI9DMd0MMQ2+0SQE9c2RhWI0HT6HAA1P
	j35Ka6hx65RRVLujkosi6LDYnAtKEeeFYBL7BXFNBb0cG13ABoqTAcmKot0wQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789137501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N6PaIRR6vaepl3eIq3aZZKgYxRKsTTVY7PDJr2bCpPY=;
	b=yjAdc7I5yIo9aNHU7bRT+dcuP++qHCpau5A/+bYZnYUDRspx1d6b9m2TOMHs93rV8gLUT+
	YsOFn4fzeqDCHoDA==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/3] irq_work: CPU-hotplug improvements on PREEMPT_RT
Date: Fri, 11 Sep 2026 16:38:11 +0200
Message-ID: <20260911143815.997254-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There was an unrelated thread which made me look into how
!IRQ_WORK_HARD_IRQ is processed on PREEMPT_RT. Turns out the queue of
callbacks gets never flushed on CPU shutdown. !PREEMPT_RT has a flush
but on PREEMPT_RT the thread context is required.
This almost never happens but if it happens it is a pain.

A small fix is for the smpboot thread to invoke the thread-function
before parking. This is an improvement. There is still a small window if
callbacks are added after the irq_work thread has been shutdown.
As a fix I added an explicit flush on the control CPU once the CPU is
dead.
From what I've seen there are two users that don't behave as expected if
invoked from the "wrong" CPU:
- cgrp_dead_tasks_iwork()
  This shouldn't be a problem because no task terminates after the
  smpboot thread parked. Everythng that was queued up before will be
  flushed during parking.
  Regardless posted
     https://lore.kernel.org/all/20260911101900.984420-1-bigeasy@linutronix=
.de/

- wake_up_klogd_work()
  This will not cause data curruption but console printing will be
  delayed until the following printk. Not pretty, posted
     https://lore.kernel.org/all/20260911103832.w6C8cT4L@linutronix.de/

Sebastian Andrzej Siewior (3):
  irq_work: Update a comment regarding CPU hotplug invocation
  irq_work: Flush lazy work CPU down on PREEMPT_RT
  smpboot: Don't park the thread if work is pending

 include/linux/irq_work.h |  2 ++
 kernel/irq_work.c        | 16 ++++++++++++----
 kernel/smp.c             |  1 +
 kernel/smpboot.c         |  6 ++++--
 4 files changed, 19 insertions(+), 6 deletions(-)

--=20
2.55.0

