Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9DF13B284
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Nov 2025 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258230; cv=none; b=AoWlrLzqWcLLx0IyEeiXCce7lnqoUbd+n3VmDIAxVkhh1ToE3kynluy3hrPvLOR747Cxxm0Mubzroq7VtO654FA9ZaHV91m+njqNCrlkRus7hmkjaFrRvqYTdIb4KdtDEh5Z15v5+FAsKcwUeGNEwcD3+XlSR/iw+AfIXRtZEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258230; c=relaxed/simple;
	bh=u6h3ZNUO0zoQExnRRWoer+eeLxLu9lBenh5UGVbqZRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeGVcu7PEHcvTo7zFCoiODIUATuWCbRggFnhbd3Ig7L9x3nsukmrTbMs0zwTuS/8QGLNsI3iElCEciGLmtNGaJEmnWFcAa1IBfeQc4lYKH7wR5KyVBewrfA6hCJOIaD/JUTW6i901suu0rjp+0eNxmLii1HTY6PcRssbyAb1SA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uqe1mHtJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uHL369yx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uqe1mHtJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uHL369yx"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764258225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0s+KZLerg4BQqOc+D0EnISDSeG6auMMoaePFrnQ7vg=;
	b=uqe1mHtJBE0uiwpwFeWJd83Bcf1PdpewYf42onChUspukV0g+K6aGaB94jfrMUUykftdYU
	giN9ZadQPRCV08kyS/mSRpzU+vsmBVrsuwfP8Gs9MLDwaLDbyK3s9/iVQXp1a/Ur/6N/+V
	WOP7RizCxyCpWSdI4nR7fsqcwM7RuOkQfQ7jeiUm6CCOzs+Cs7wTZvT3z+QP1HoLJSL+kD
	pfEaNyCi12nTWtN/JZkmETO/65w1YQ9NWLglSoLewtADJ0RRhVwiC+Ts8S14fgCTphPWhh
	9Tmj1MKnqU38LIn+OoWP/41y7AtdtrKRtJF64H9NatcEY/jYWdysfxm0dk+3Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764258225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0s+KZLerg4BQqOc+D0EnISDSeG6auMMoaePFrnQ7vg=;
	b=uHL369yxYVEvixoa0mtSbmj3dZsADFd/GX2xVliu0LvkPg1OfAgpAO1a/+zUvya241Y9MF
	pcpE9GLdgsjkQFCg==
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Clark Williams <clrkwllms@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/3] Documentation: update config name in real-time architecture support
Date: Thu, 27 Nov 2025 16:43:42 +0100
Message-ID: <20251127154343.292156-3-bigeasy@linutronix.de>
In-Reply-To: <20251127154343.292156-1-bigeasy@linutronix.de>
References: <20251127154343.292156-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 4843a45ef9fe8 ("entry: Rename "kvm" entry code assets to "virt"
to genericize APIs") renames the config KVM_XFER_TO_GUEST_WORK to
VIRT_XFER_TO_GUEST_WORK.

Adjust the documentation to the current situation, and specifically
refer to the new name of the config.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/core-api/real-time/architecture-porting.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/real-time/architecture-porting.rst b/Do=
cumentation/core-api/real-time/architecture-porting.rst
index d822fac29922d..c90a426d80624 100644
--- a/Documentation/core-api/real-time/architecture-porting.rst
+++ b/Documentation/core-api/real-time/architecture-porting.rst
@@ -35,7 +35,8 @@ POSIX CPU timers and KVM
   POSIX CPU timers must expire from thread context rather than directly wi=
thin
   the timer interrupt. This behavior is enabled by setting the configurati=
on
   option CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK.
-  When KVM is enabled, CONFIG_KVM_XFER_TO_GUEST_WORK must also be set to e=
nsure
+  When virtualization support, such as KVM, is enabled,
+  CONFIG_VIRT_XFER_TO_GUEST_WORK must also be set to ensure
   that any pending work, such as POSIX timer expiration, is handled before
   transitioning into guest mode.
=20
--=20
2.51.0

