Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D526315767
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Nov 2025 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638637; cv=none; b=pGDiyc0LPzCVPudUtf0plK3RCNkZ/xKjp9kc9a6IgK/VZeyH2QecY5M4++Dw7FX0YZ6Yx/5CPp7mp3TmO2UrNj3LGaX7gTnHJPW49xlNzQT/GMBO7ZW9cmBExMYfYGcRhbOPFCGTqsMXdhSbiUBxtH8yqfTO1mD4yEHYXfZBcU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638637; c=relaxed/simple;
	bh=n4xhlXgGFxvyLf4Y2Uwo0aMLHx0Nalo6k0hY2mRFNU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V89BGbHfOnfebnJyBtQpIlxNjVRqrakdVekMh5LXY9F7o4fItlTuKAKtELalfDJniE3dCcf4Fb9cXnwK6cIDQZTGVidtbJpItxGLHJnl0z1t3ElF51CDgbzCcbXntOSidUJOHFn+kIM7XfldtDYBVTFx+37Lf8A5aG/C5YSfZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OYaeRMev; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E4zINMLa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OYaeRMev";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E4zINMLa"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763638634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Z7FbmHbPk7jlB4aC3UbKjF1UgKb17UqpSn//sPlqco=;
	b=OYaeRMevtzcMJQNHDO95JCITv9ovyMBu3t9V/i2AUNtefmYItF1QkskQVu9NzaPOvTYK9b
	rqn6WRK3qDq59MlgM7BRBAnx9hPwdqmIgMGBlI3tOQfQCkq6Gk+GDVe/L/Me8OW1dWkR/7
	saVmXtuzMpk1F40uQz1bVdzsgQyi+hVPc6Y7oqWkdf3iCWCmtjPtUPd+YIymgQ41pb+znw
	R6wuSxxHxWk++zR9jl8hOo9GoBM+9VJKqBlZyi03z326biT9kHCJlgcflTK+Mj3UMMbBRe
	3WvG2n5phvK8ZWx8zrmokDKgzs15B+uo99n2/IGyBehhLhyateY4dqKG1SppzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763638634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Z7FbmHbPk7jlB4aC3UbKjF1UgKb17UqpSn//sPlqco=;
	b=E4zINMLaAUxamLdzpLh+Eg2h2juGcwhfMN3Ysq+I0uTfRia3cM11fgMWAwztSo8dzMVaCk
	mwDjMpIY9V8MEODg==
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Clark Williams <clrkwllms@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] MAINTAINERS: Add doc files on real-time support to Real-time Linux
Date: Thu, 20 Nov 2025 12:37:08 +0100
Message-ID: <20251120113708.83671-4-bigeasy@linutronix.de>
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

Commit f51fe3b7e48c ("Documentation: Add real-time to core-api") adds new
documentation on real-time support, i.e., PREEMPT_RT. So, add a file entry
for that directory to the corresponding section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 836ec73c604d6..a98668acce039 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21823,6 +21823,7 @@ M:	Clark Williams <clrkwllms@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 L:	linux-rt-devel@lists.linux.dev
 S:	Supported
+F:	Documentation/core-api/real-time/
 K:	PREEMPT_RT
=20
 REALTEK AUDIO CODECS
--=20
2.51.0

