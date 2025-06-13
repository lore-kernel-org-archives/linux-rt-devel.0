Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D52C15B8
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Jun 2025 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749812219; cv=none; b=N8sOV8FESFDLF/qSEIc/32JUhwoiA/uGXvP6B9gshe4sc8m4pqyGzULHKvYGxBfw2DgXeziTFkNPyTYDYUtsh8AFgtVwDZyfpBItXvBqLYnEnZ1+GyhK4A7KDcaNTZ7hquSesjp0PkRzQDSJu7+VCzgVFVafoUdJtlUNu0HZZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749812219; c=relaxed/simple;
	bh=JITvwUOEuK6VMx0vH2dZBuvurvXF7sYMUXnX2S5XEz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G658Xp+zGV5tbHm4HPOcSOgra70s6j+epb1MJ7VcX9O0/OGrQTsS3VvS7aG17DtX7cffpoPFAic4oOi7iq5of21J2VcV7kGretY1WUuGFkz7RTCiR0yjJg1xWHm5zXqV08Gk/X96fVTcv3NmWP9lNFFs0THulIAJi440lFoK6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O5WVQyI2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KfJgzGdw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O5WVQyI2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KfJgzGdw"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749812216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0sTqX2tcvrlg+m1/ilDAXxr0xRBg7UGzOmG2GbyljDc=;
	b=O5WVQyI2bsVC4qw4vaRyH1IC0CHCv3w3un8jiVX7BY8O/vM3h+GIRIdFiIDBqVvdl9edLK
	gjCRrbxeNjXimysZ6AfSZYiHmPTJO6HJ4wclnj1bd5wACY7lUK5DYzTm3aJPyl/Hw5BTMP
	vbiJDcTS8AyyRi8xQhGe6YlroCn9x7VdB1Evw20Yif1d8coOjy8mqSgUNxAAkuDxG45Bte
	ZS3wNPEVC24buxIXeG1HlWblc04Iwuo9aLs0xZ7m+6sWbKnXHccEOwvkTGlS8auaS2ovzu
	Moa3dEvVfeEe/bRLHJzRkci12iChu68Sr/PlgzPzxZ6wSGwcSD5f6uvgisAqHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749812216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0sTqX2tcvrlg+m1/ilDAXxr0xRBg7UGzOmG2GbyljDc=;
	b=KfJgzGdwN1ZZVng4IewzM4dIVR5F0iwnl75zrpX5cN68RdnFqXor599OwPSgM+dqMPBiK9
	HH+hqijQHy405WDQ==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 0/1] softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT
Date: Fri, 13 Jun 2025 12:56:52 +0200
Message-ID: <20250613105653.1860729-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After auditing the tree most of the local-BH locks are in tree now or
the code has been changed to avoid the per-CPU ressource.

There are still a few places missing. While those are worked on, this
patch allows to test the unlocked behaviour. Without the explicit
softirq synchronisation, one softirq can interrupt and nest within.

This is what the behaviour can look like:

|     ktimers/20-204  [020] ..s.1   33.291036: softirq_entry: vec=3D1 [acti=
on=3DTIMER]
|     ktimers/20-204  [020] d.s42   33.291054: sched_wakeup: comm=3Dkworker=
/u133:3 pid=3D1215 prio=3D120 target_cpu=3D020
|     ktimers/20-204  [020] d.H22   33.291146: irq_handler_entry: irq=3D37 =
name=3Dahci[0000:00:1f.2]
|     ktimers/20-204  [020] d.H22   33.291147: irq_handler_exit: irq=3D37 r=
et=3Dhandled
|     ktimers/20-204  [020] dNH52   33.291152: sched_wakeup: comm=3Dirq/37-=
ahci[000 pid=3D810 prio=3D49 target_cpu=3D020
|     ktimers/20-204  [020] d.s22   33.291162: sched_switch: prev_comm=3Dkt=
imers/20 prev_pid=3D204 prev_prio=3D98 prev_state=3DR+ =3D=3D> next_comm=3D=
irq/37-ahci[000 next_pid=3D810 next_prio=3D49
|irq/37-ahci[000-810  [020] D..12   33.291177: softirq_raise: vec=3D4 [acti=
on=3DBLOCK]
|irq/37-ahci[000-810  [020] ..s.1   33.291179: softirq_entry: vec=3D4 [acti=
on=3DBLOCK]
^^
|irq/37-ahci[000-810  [020] ..s.1   33.291187: softirq_exit: vec=3D4 [actio=
n=3DBLOCK]
|irq/37-ahci[000-810  [020] d..2.   33.291195: sched_switch: prev_comm=3Dir=
q/37-ahci[000 prev_pid=3D810 prev_prio=3D49 prev_state=3DS =3D=3D> next_com=
m=3Dktimers/20 next_pid=3D204 next_prio=3D98
|     ktimers/20-204  [020] ..s.1   33.291227: softirq_exit: vec=3D1 [actio=
n=3DTIMER]


Sebastian Andrzej Siewior (1):
  softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT

 kernel/Kconfig.preempt | 13 +++++++
 kernel/softirq.c       | 83 ++++++++++++++++++++++++++++++++----------
 2 files changed, 76 insertions(+), 20 deletions(-)

--=20
2.49.0

