Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EE3128DF
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Nov 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257820; cv=none; b=FAt5J+0RXRV7b0XdU+8TEmbu85uyPOTDvLDGOpdONQQnBik3YbtPz5UDaWY6Qf91DaR6IwYwc1VHVnWdMfcScXIXyqDxTp6min/aZyrF6GXwrLuwMl+/WMT/dPT5DuX/u+n65XSxgz+ubVt/oFO5kZ1Fzl88wexzqEMWvdU+r30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257820; c=relaxed/simple;
	bh=wrA1NRobAbwFgSPDndeORTIXaKSPnKOpQMYhwQ/l7Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srpBMHUFDwqcngoxfpmuJZt48J5AVcp5keB7FalhmCd65aShGa7ZvjHfh2Uto+BW8Lj3PrmD7z/u0qL5Em8vNNQFjPH3MxldchYO0XXAU8q7bEVX8yHsYic5qRFjpO+HOJ6pFhc7u0KiW5UqV6rA/havADDXB9b/cfnSHvHIaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MxSRoaL0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7l6ImFoy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MxSRoaL0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7l6ImFoy"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764257817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Yk97FXDix9PYYN0LiSHQLK46kOWiOeY6+fuEgQLZD8=;
	b=MxSRoaL0kV2KdQEEblnDdpKO6bzWcT9dSpTQ91vJaqHrJ7Cmmn7p2rZMhSDoXHZlDzLXu2
	bO5v3L0+ypUONwnrrQob5rgavfwgKu4IsByYyBpFbca6xxO1PPbpnbaBFxhJH4OALwOaU/
	m31ZCiUHT8ixBPVHD5SdcoXbv+46fwITEJAi3j4kcQkHqVK8c+TY1q2IGz0o3YGhFrAk+P
	JuRi9R+pz9rXqEDiGmOqlO29pUiKGGqcO9jDdjsO083c2Owxn7hE/CK+Ef0CPYdEqHpo1D
	8znADKpo8MA2fnpZu7rn0BQjcWdnsYAooAEc2KIEDtLZ6By+KDuWcfJRyVdv2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764257817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Yk97FXDix9PYYN0LiSHQLK46kOWiOeY6+fuEgQLZD8=;
	b=7l6ImFoyYqQ4liLk7Ujx9g9DqaYQLbOXpzGv+BOSQuvuH3RHlQ1GOVvZe1kJtyxc5QuAZ0
	sZy6W8Z6wHFGHFCw==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING
Date: Thu, 27 Nov 2025 16:36:51 +0100
Message-ID: <20251127153652.291697-2-bigeasy@linutronix.de>
In-Reply-To: <20251127153652.291697-1-bigeasy@linutronix.de>
References: <20251127153652.291697-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The pool of free objects is refilled on several occasions such as object
initialisation. On PREEMPT_RT refilling is limited to preemptible
sections due to sleeping locks used by the memory allocator. The system
boots with disabled interrupts so the pool can not be refilled.

If too many objects are initialized and the pool gets empty then
debugobjects disables itself.

Refiling can also happen early in the boot with disabled interrupts as
long as the scheduler is not operational. If the scheduler can not
preempt a task then a sleeping lock can not be contended.

Allow to additionally refill the pool if the scheduler is not
operational.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7f50c4480a4e3..7017e5c8f32dd 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -714,7 +714,7 @@ static void debug_objects_fill_pool(void)
 	 * raw_spinlock_t are basically the same type and this lock-type
 	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYS=
TEM_SCHEDULING) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
--=20
2.51.0

