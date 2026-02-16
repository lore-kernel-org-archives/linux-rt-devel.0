Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B13101D2
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Feb 2026 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249437; cv=none; b=eltxmSHjuXyLaRp6vzoR77zFoTqW8+UB6NARIun100TwmxUrx+kqn66eucXh7goMKxPpW7ja35lk390Knp6MNEcGxun0ttl3CcEAZaCuAo4n/uVo/9XiZ3hhUqee9lXQbfswKDajOiEjfAYLNVu67bIoUXhv+VR1+Hfo+DOAY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249437; c=relaxed/simple;
	bh=cbfGdeTGS5fXk39OIwNWosl7v4mPCJc/RrIYmSbReso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLZAoGaawiMMnd6sdCj9MW5FOP/1VwvCdKFa5qucgya0aVcyPEYlgqC4JDIX6v+mWhKLdTmngziPvuIb09dSac/fdZQOkAPgvc14Vkrg5tN71yuyg9JUZ1maMysvGIXT91kOwekAd8tm+PYKIn1cK4lCLfOfIKeNhlI+QanPd50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=jchOjHxX; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="jchOjHxX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771249415; x=1771854215; i=spasswolf@web.de;
	bh=cbfGdeTGS5fXk39OIwNWosl7v4mPCJc/RrIYmSbReso=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jchOjHxXF4BHl5EU7wSn2AOR5Yw3MGsJsWu2lzZST2OnVDQLAKNyio5XcLPq96Tf
	 8DL6xwE9WpErupsrSzUnLmqZc3CTroAlKyNWenfYkyEJXH/YEFL/++W6w5A77nn/z
	 VBtcF+afHErCZuOSqEADjVf1kB5TWv/bMPC8a1dlg/O1lBCz1gEdCjGheVBiBciBF
	 kQB9t66LJCwFKyEfF0BG9QFr1AMUDMyxE4WZawHbfJKtrfZnxk83lg9pWAmOvXUCO
	 s4WqYg9iODDSWhgdLfPfQiNACgqIqJvjwj1zdNMjuB9DyeiHyZCWq5zq9L7mlITPn
	 S7ud8AXKaCsoQ4nniw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1McIki-1vMCyI3SoO-00nLhS; Mon, 16 Feb 2026 14:43:34 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: "Dead loop on virtual device" error without softirq-BKL on PREEMPT_RT
Date: Mon, 16 Feb 2026 14:43:32 +0100
Message-ID: <20260216134333.412332-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eNFA2xR+H/tybXJSfyN3R+xnOwZHN1BF4Izv32xgZFEIRBZS6s+
 L3FQhMM0qO6qc1saY8EN3h3Uk9UoNMgfLSvscd29VcjnqZKRo53dI42W3QvQqM3qaZmHl4u
 RzcgQZwmT6CJjq7uCedoqDZ2a1Y0sY1xuWpYA7uDWcvZH9a8EmT0N0DJ2IuHhOe6kePVfgP
 5fPg6bONc9H/ZOaOV0pPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zm2ADz2fIyg=;B2+OB3ytsPiiicLiNNsbeyR6xbh
 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
 xZAyy4lCymbyiyj+4=

Starting with linux-6.18, I see the following log messages

2026-02-15T23:50:17.558716+01:00 [ T1559] Dead loop on virtual device wlp4s0, fix it urgently!
2026-02-15T23:50:17.558737+01:00 [ T1559] Dead loop on virtual device wlp4s0, fix it urgently!
[...]

regarding my wireless network device

04:00.0 Network controller [0280]: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz [14c3:0608]

I bisected this (from v6.17 to v6.18) and got this as the first bad commit:
3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")

Using CONFIG_PREEMPT_RT_NEEDS_BH_LOCK=y in v6.18.10 fixes the issue.

Bert Karwatzki
