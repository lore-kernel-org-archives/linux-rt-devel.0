Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427021922C0
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590496; cv=none; b=DIG8+OeNiDzVLOdjw/5Vl6YA8F6EVdSX8noElmy6aIy0wp3GummXh4S0KfmmVBSLMXQxqBksTogd65Qk+5uj219WHuUOV/KZzvGH7VflIHF54KdMtzIxiHCGX3dyEER/12bGaPhvHj1GWXN5ia1R/3wLxsV0jXayyEPFHDfyhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590496; c=relaxed/simple;
	bh=f+UdcAGiBhzcRrLBexR8JxyBZ+p87Oq5cSZXCDfI05U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbaWwv4xfOnC5JUDBd00xt+IWk36JUr/bm2nAjns60PQwgZpjjGTZCLkybJ08WWXAX6THki+VeQ8uvI9FQgIqRh2T0bzNnFN99BdO4gagjW7oE5V+snNrgtP2m87Yk5UpqrzS9/MAcB6tXj35Bj4YrSgKt2FL/YLXiN/x+BjD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZM9hYZoI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t1l+seC8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZM9hYZoI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1l+seC8"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752590492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+UdcAGiBhzcRrLBexR8JxyBZ+p87Oq5cSZXCDfI05U=;
	b=ZM9hYZoI2yCx7OcML8cDVGCFIzx3fBIrQJyYj4RrLY4Z1B/VVkvYzOfedvgtmXLobQHlWk
	ciiGWGyiCGV7G7w4Co7rCUUPq9eUnqddrZN/IZPwSFhHAfhhrDpz6e6Hvjujhjda5T4AjL
	5G5RUwhF5nDo7YZ+wUSFeBoOFktL4YIBFBFsoQpjRRs8hqI3Nlolr9XJqQVnh8taM+rQI4
	0BAVV0FGfSV+7HigrL8RpjfxfngmVz5srWptYLTS26qemyVQ6kLSoWClZJpu+uKIv6a4Ea
	nSrodAufhy2KWHLqn7fwUpxrUr/dvEh/yuGYpLDWdqwFMLDqALoadEeg7NQueQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752590492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+UdcAGiBhzcRrLBexR8JxyBZ+p87Oq5cSZXCDfI05U=;
	b=t1l+seC8FWD8GTwyVnHiJTZLlRMmW0v3/HWGFqJxExZswwcWk9sSft+I7azd+coGDXalCp
	xKgTcnE8KoHgUMAg==
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] Documentation: locking: Add local_lock_nested_bh() to locktypes
Date: Tue, 15 Jul 2025 16:41:26 +0200
Message-ID: <20250715144127.697787-3-bigeasy@linutronix.de>
In-Reply-To: <20250715144127.697787-1-bigeasy@linutronix.de>
References: <20250715144127.697787-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

local_lock_nested_bh() is used within networking where applicable.
Document why it is used and how it behaves.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/locking/locktypes.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/lo=
cktypes.rst
index 80c914f6eae7a..4851ec1232058 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -204,6 +204,27 @@ per-CPU data structures on a non PREEMPT_RT kernel.
 local_lock is not suitable to protect against preemption or interrupts on a
 PREEMPT_RT kernel due to the PREEMPT_RT specific spinlock_t semantics.
=20
+CPU local scope and bottom-half
+-------------------------------
+
+Per-CPU variables that are accessed only in softirq context should not rel=
y on
+the assumption that this context is implicitly protected due to being
+non-preemptible. In a PREEMPT_RT kernel, softirq context is preemptible, a=
nd
+synchronizing every bottom-half-disabled section via implicit context resu=
lts
+in an implicit per-CPU "big kernel lock."
+
+A local_lock_t together with local_lock_nested_bh() and
+local_unlock_nested_bh() for locking operations help to identify the locki=
ng
+scope.
+
+With lockdep is enabled, these functions verify that data structure access
+occurs within softirq context.
+Unlike local_lock(), local_unlock_nested_bh() does not disable preemption =
and
+does not add overhead when used without lockdep.
+
+On a PREEMPT_RT kernel, local_lock_t behaves as a real lock and
+local_unlock_nested_bh() serializes access to the data structure, which al=
lows
+removal of serialization via local_bh_disable().
=20
 raw_spinlock_t and spinlock_t
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
--=20
2.50.0

