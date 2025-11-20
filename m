Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816052D4B40
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Nov 2025 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638637; cv=none; b=SE0YyCzBdsoPxm/1xl9OI5nuKP4jqDvIXvn636alXYMz+xv6PXeSyiaF7vNv8XzSbBXqbHTvJeT7JCBjkJCob+4hgO04RTcslINjmb0HIbuEqAb7Skb+2CEM9vf8orFS4uPJB1BIwZ91vy9VQWIu6ltBCpziY9hVjCUI9IZxETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638637; c=relaxed/simple;
	bh=u6h3ZNUO0zoQExnRRWoer+eeLxLu9lBenh5UGVbqZRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJoS65Nyselo+4PafTVbEC6a2Yb4gs6aN+3SJyTthXWGZZhA6o2sy4WmWyM1pp+Vv5txG+/ZW5/D4pUclGIVgZBm9PNXQagppk3IBECl/uaxHLHxTwIDN+TWTAEgn9sP+gXH7GN0xRMqR1aOTnR4JsGC/PQHxYugm2u3IhZ9I3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d9BbKUOC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1GcPyv+o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d9BbKUOC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1GcPyv+o"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763638633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0s+KZLerg4BQqOc+D0EnISDSeG6auMMoaePFrnQ7vg=;
	b=d9BbKUOCrhqNNIXBfPVaxQBly+gRXj0D5F8vGnZxC8A15sPvM2eIisQKgXW53uSqjRwg7W
	TFyPBo8TZ/xyzZYSl1Ghn3RjMfoC6bAZsZvVKzO0rvu11YaNuLxlD+iGPoyaLOG9V0LGbq
	cyKRJ9WvEj3KO6x70XI+PM9IinEy60Tpz9pZ6Kl50uJQRf4V3QaGtOdBEkf3+oTuLCPFjb
	9wguuVmooig94tsI0vfjXXvia4Z/rixlaSBriZ3fjtdxipjCr6sJhdjvbvrO/RJpYof1Tn
	isurdtiEk/dy+8B4IvOpqV1yWvmctbFSD5LLFR5VpyOZ5zuD2x+ml1Ao+QXCQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763638633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0s+KZLerg4BQqOc+D0EnISDSeG6auMMoaePFrnQ7vg=;
	b=1GcPyv+ouFXJM4QnwIDSrVtfTqP1RP0MLaeDXfXAlkriFtYN1wP17YVQ8obCexZViZriI+
	ywWB7RegZcISFyCw==
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Clark Williams <clrkwllms@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] Documentation: update config name in real-time architecture support
Date: Thu, 20 Nov 2025 12:37:07 +0100
Message-ID: <20251120113708.83671-3-bigeasy@linutronix.de>
In-Reply-To: <20251120113708.83671-1-bigeasy@linutronix.de>
References: <20251120113708.83671-1-bigeasy@linutronix.de>
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

