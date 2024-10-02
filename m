Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F71D0F7F
	for <linux-rt-devel@lists.linux.dev>; Wed,  2 Oct 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884004; cv=none; b=A0gr3Bps1T+WLYpuw0hjF058vdrpt7BpQLLlm0QtaJfIwgKxTHbyAheyeYfNPIiTp2XSJoAe5ut7t7tbLMNR0dYCYrNy8ydOb/GDwk3kvWSnG6g4b+WCiNT2y7mXuCvj25BSzCfPpamNgME4xXd4vV82xH4pHVWIMiR9OclrhD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884004; c=relaxed/simple;
	bh=aMS347hR22cBHK7Fa3FQQ9oDVPAe8o+jQ/THkNYozyc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BgnRWKVLr9O2DxfOUMxoT+7411VXYreGA52P2rOQ6LJU10sHTDEgPm+A0YGbcHwhiIkcMaHO+TWdjM3NViCsDEk33gRvyRebb+g2KOYUqG81cZOr01oGUtO2sAWE1V6YHmi+5xG33I4s2jtft0LYfq4m3Jr81A5sEsOtW2OLo/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KfxgT0rZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lfnbjysa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KfxgT0rZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lfnbjysa"
Date: Wed, 2 Oct 2024 17:46:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727884001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=FW8/99YybjJuV/wBIvZitq3qs4bAn3VtDT4B5j35xbs=;
	b=KfxgT0rZmg35otNIIguPduRN+r5Rhwh6TXRGGN3Ucagv/mF2xi3UPhtVOq2Ys8kW86eBEq
	7WJJ9w0UkAlW3FKW82fPy5ZcSl8sVPyLFiGReH1C41YtbPQONs0sWiuRkquZYyAUo34D+u
	eEyjrYLwbdUeQUir0yonkif74fOvCTvAALyglH4m/AzGhU8FrIv33F+RQVs1kTKqFw4Ct7
	W2u0dT7g5PGxVricTvgAIsct/XTUS4y64y+NdxOVh+2JSal/Dw7UfCbtBq/6TFh8XYeye1
	Bb3jCJmfVe/E48bC7rmzZPOOiUoVpFmbG46NcxGIikRSpt/fiR/mXvsCYfRL3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727884001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=FW8/99YybjJuV/wBIvZitq3qs4bAn3VtDT4B5j35xbs=;
	b=LfnbjysaXqTHlFF6FV5IhJdUgAkl6AUm9XSY/SBNgDPgl4fdor6jEnowY8nVXvOZdNEStc
	4qxqNhuwKmqqnDAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] MAINTAINERS: Add an entry for PREEMPT_RT.
Message-ID: <20241002154639.89wWS_OU@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Add a maintainers entry now that the PREEMPT_RT bits are merged. Steven
volunteered and asked for the list.
There are no files associated with this entry since it is spread over
the kernel. It serves as entry for people knowing what they look for.
There is a keyword added so if PREEMPT_RT is mentioned somewhere, then
the entry will be picked up.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f8..83285c41b0ef7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19514,6 +19514,13 @@ S:	Maintained
 F:	Documentation/tools/rtla/
 F:	tools/tracing/rtla/
 
+Real-time Linux (PREEMPT_RT)
+M:	Steven Rostedt <rostedt@goodmis.org>
+M:	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+L:	linux-rt-devel@lists.linux.dev
+S:	Supported
+K:	PREEMPT_RT
+
 REALTEK AUDIO CODECS
 M:	Oder Chiou <oder_chiou@realtek.com>
 S:	Maintained
-- 
2.45.2

