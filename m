Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38D2F8BE0
	for <linux-rt-devel@lists.linux.dev>; Fri, 15 Aug 2025 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250747; cv=none; b=sJ8CEGDjLGEiWT+5iewyArp0NSGIOV6Pl4aN3q2U94zSBLQF3gNd1J1qv5HSJeN/5Fb7u9c6+b+eRBSH6fKxIop2mqgfMoQD0a1qESHDkLByrxivhCwRNfIQIAqedfDEXDpvP4pX7Dx8EEOJEZPv+L0xsFlIza9tAC4WEPsomnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250747; c=relaxed/simple;
	bh=J8JG3FUkOHDeFdcfTPYWnCrIedCIVX6GDxzj7JdiD08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eppIyoYHgM9XwYkhn4K0Eok/79olb+P+ILfa7+R5YMLiWXB8tl4fDBNBS36I5CkGKFf6qBU8O0sWh9W/6VAyw+t/v/p1d/xvS989Btz43D926KUSzx42wUpBJtb28EiTgx3aL2JuujYzgNLZfHyiWRQPfQxjt5GKRludU/m1KrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nxg60v02; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2cG1T6qg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nxg60v02";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2cG1T6qg"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755250743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8JG3FUkOHDeFdcfTPYWnCrIedCIVX6GDxzj7JdiD08=;
	b=nxg60v02bwAW52gGiBBMEyvOfpiGl9JCoDo83iKfItMpDJBlBb2ShirwkK+PtayOoZb7FF
	3RYIx8f0xWTFIyWTvddv1InvAkXMp2iABOm0au1dvAIOsBACksx2pz8aSM0umpln8LnV3i
	dhX/WeVYXmMQXlIKWTwju6OjnuzmQWDgs6wo1H9ptIP44ZVJyRvOModDNGZBrbjcgJuStt
	XSeiDvhl+emM/wXfFJ3ELZsdzs0yQv5xDytFngw+YYm0e7Xe02VdMUyyShxtzWYdgt7FwY
	unfGuIum4MjOyBSowuKKL0wZh9yjyjPNCHF6qn3F/pCiiaXLQYzpzEgJd8S1KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755250743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8JG3FUkOHDeFdcfTPYWnCrIedCIVX6GDxzj7JdiD08=;
	b=2cG1T6qgq9dXkxNiajif+kfUsrT/HCk2Z/3wM9aJOI5Uy+qiJ+HcpDf3mgQRUuqYZcaGHa
	6qZAt2oHllsJmlAQ==
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
Subject: [PATCH v2 2/3] Documentation: locking: Add local_lock_nested_bh() to locktypes
Date: Fri, 15 Aug 2025 11:38:56 +0200
Message-ID: <20250815093858.930751-3-bigeasy@linutronix.de>
In-Reply-To: <20250815093858.930751-1-bigeasy@linutronix.de>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
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
index 80c914f6eae7a..37b6a5670c2fa 100644
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
+When lockdep is enabled, these functions verify that data structure access
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
2.50.1

