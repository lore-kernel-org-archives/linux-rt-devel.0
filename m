Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5253375A6
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Nov 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258231; cv=none; b=qxdMEvUe/FpKZ38MjOitEJSUxprWrxJEcVz97k2rxYrI6rZ7D/xBPa4sPPt1XjCdLD0jKyChpReY90dQAJgJ2xZ+tZLkDM8jyTcFzBXGEVG/RwYLnIzIsBNJHuZaTGWb/y9P79wYUYVqVlbIo01+L7Y7fsWq24mXLY6ve397PL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258231; c=relaxed/simple;
	bh=sKAt2qZ7hQOZ3KL8sG8l78XJU+EQfXJWuvm2wnzuKhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JclsoTJWvIJ879NzaveXLUaswJHYsw2AHkCEuD44EwOlH8ZOKqIsnZCSfyQcCtyKMGd4faGdBGATRQ1XgBYLVR+iIVAuqdVVdiClBxez72NbIeuHBRxhcAlW3PMZJ/aXmR95qiu+6QLPepFK6TkVvNpWenk2/SHK0wtEMylqxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZKbrMrZy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vZfnOTsR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZKbrMrZy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vZfnOTsR"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764258226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVj5TvL2s7i3Mw10ulGU+jqn8PAnn8DFeIvfN4kIp0I=;
	b=ZKbrMrZysTJ1hkJvii7nuhYMeq6HkIi01jrHEci2wUjOck0AfeO+D4YF7yd4J5vKjCI5Ed
	7pxkYg9DwRaYh4B508nnchT6KnQC0AmHRTuz/wrVQShLylGNwC/t9lAiP0pKPUTUeu0HFl
	tSfATMKmwQ/J5uTA1w5pPIE3tp8zOLom7aDRCgT8t+dwr2+O8mECjSsG4rLtPhuIXZxEd8
	ZBmbTZbaOzghJ/+aD/A0S8AVf8+5PYJ/dUcPPsgb6ZusR5Ko1yPUE2SsI6yc26ngMMpYq3
	jQS3FKUiB29IGRGZG1M8Au9P7+0mT3ZhuaVmcCgW3xzUykd+SERU2kBLBrjVwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764258226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVj5TvL2s7i3Mw10ulGU+jqn8PAnn8DFeIvfN4kIp0I=;
	b=vZfnOTsRYkWLA11d1DASbl4bWnm679EnoFHjAHG0Ij4SsanznSa1Ei36AMR9jokCbLsRLL
	ipGCHfrvaA0umkCQ==
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Clark Williams <clrkwllms@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/3] MAINTAINERS: Add doc files on real-time support to Real-time Linux
Date: Thu, 27 Nov 2025 16:43:43 +0100
Message-ID: <20251127154343.292156-4-bigeasy@linutronix.de>
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

Commit f51fe3b7e48c ("Documentation: Add real-time to core-api") adds new
documentation on real-time support, i.e., PREEMPT_RT. So, add a file entry
for that directory to the corresponding section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55026f6bc0a0b..76b976e447e12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21943,6 +21943,7 @@ M:	Clark Williams <clrkwllms@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 L:	linux-rt-devel@lists.linux.dev
 S:	Supported
+F:	Documentation/core-api/real-time/
 K:	PREEMPT_RT
=20
 REALTEK AUDIO CODECS
--=20
2.51.0

