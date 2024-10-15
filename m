Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC91CB9E4
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Oct 2024 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005098; cv=none; b=UqS+2TFhXlehFbrGTrer1cKM0tRuqG+MEPi1Ct3OrkXAipr+jabsHqsnR1JmwaF8D1PO6Xg0LOlMIMyN5mO1KlasV1EKKBoebVX6dcLXDySFl8d54oiSms4AKQ0BU/rC+GYcmFnxikQxQHmMiJElAUxf+4RwFPubtQKN6tbMenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005098; c=relaxed/simple;
	bh=h3IDuutdans6FJkhit/jWNEbsThjTFbI3JNngFyapZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfftlmAxox/Tiwu2VKPJVsf1VNt/8Jgcp9PN/Sm3dXOOUo2eXQhee6dM/7P4HoybgHdeUrg4+nv7KdciIk3H7bBPKTr4GhhTw5ySZXpU7jwnMhOPGEU20ltNSu3WIGeeZ4CSiTLcBQRmp9/0gzXIneoZEDA8mhzrHw5zOyPDBb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gq76I6ZW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BTGeIvTK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gq76I6ZW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BTGeIvTK"
Date: Tue, 15 Oct 2024 17:11:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729005094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KH+qQMF7rOFjXpz03XT2YPZOGuvYkYLCqruf/24KOa8=;
	b=gq76I6ZWqA8Je+qG7qVx+QouvSIFUoa73VKPYnc/BrBDF1CRt+ND5q9ESRnQUfWO5YF5Ox
	6gQ9dB4WKYagL8ZIwK2uuEyDNd5JvsJ6rIZ+PYo1xwFUOwSjsI4iIfGVKPLFQO1APaiPxR
	CUCpS0mP/q0Ym9UBehZCHyMDRTjCbBl3xX0l4tb5+umLcSMGtDMgyd+OyGk7GxgMbE4ZQa
	ARWX5gkDagKWlT8JX+ROz+nVSEHCRURIK6tYmyjbpzH1icUQTWZ+uHEaRMHzxMzIA56EmQ
	DGlZ62PDeH97PNYRwPLFn0wCTmfZXD3rAQFsKCdLh3zq1thT1GxuzHlF9vMZTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729005094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KH+qQMF7rOFjXpz03XT2YPZOGuvYkYLCqruf/24KOa8=;
	b=BTGeIvTKrXavJ4Vm/yTvWUqMcd/tQjVDEI1cHe/VkfgVLju1YeG8YbX+KjulosHjift5T8
	78fSPgev4Rd4dwDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>
Subject: [PATCH v2] MAINTAINERS: Add an entry for PREEMPT_RT.
Message-ID: <20241015151132.Erx81G9f@linutronix.de>
References: <20241002154639.89wWS_OU@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241002154639.89wWS_OU@linutronix.de>

Add a maintainers entry now that the PREEMPT_RT bits are merged. Steven
volunteered and asked for the list.
There are no files associated with this entry since it is spread over
the kernel. It serves as entry for people knowing what they look for.
There is a keyword added so if PREEMPT_RT is mentioned somewhere, then
the entry will be picked up.

Acked-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - Add Clark
  - Add Pavel's Ack.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad507f49324a..856723985a768 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19523,6 +19523,14 @@ S:	Maintained
 F:	Documentation/tools/rtla/
 F:	tools/tracing/rtla/
=20
+Real-time Linux (PREEMPT_RT)
+M:	Clark Williams <clrkwllms@kernel.org>
+M:	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+M:	Steven Rostedt <rostedt@goodmis.org>
+L:	linux-rt-devel@lists.linux.dev
+S:	Supported
+K:	PREEMPT_RT
+
 REALTEK AUDIO CODECS
 M:	Oder Chiou <oder_chiou@realtek.com>
 S:	Maintained
--=20
2.45.2

