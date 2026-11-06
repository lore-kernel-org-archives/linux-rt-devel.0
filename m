Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956807;
	b=AqmAq2qPMT6zL0O5lQTV3JVqytr70njOTGwjYplJHhL93370oYh/EpB1c/xMBGHRafw1
	 fnv9P6geiIvaelqhD0Zk3whmACcA2kW1Eyj+o2J8NrLXH5bF4gLCpoesntJttFIWM8Nn+
	 lQrSquLjXSAWP4iv1CD+QnXKFu9KuDXJefSDqfIbigs2JrEM55z0XJfG2/0tmdIvHQQP3
	 v5ReMKuf8DHdq/lGirvusEcHfg8BkpfXg5FHoNcmg0T4qSdLQbGWNqXTfwpeuHyilKnNM
	 D4t3sdV5zLezcwDFw89WV2ILj1drM0xLon2mPRds4KMwfcSc7wKZZkkBNDC63BvwBpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956807;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X+RIYSJuCkjGJWvn9kpp/Ob8ans1MXDZ31RXyzn2feM=;
	b=QhfZ2NsGp+hO6CQyB9q02O6omNsrz9aNVSelpjtBzEWJOtd0hhxDPrDGd4T7OewD4Yc9
	 8cUGG6uuDj97JMfSPEV8yfMVSS3/rKkiHdeQOAaGrVidsrbpdegBG/Kjdyb2qOAblCERm
	 6S9+phBUGuQO9t1v5wNYsuYauXBAIl8oqI8mfhYHL8WqaMgmL3rpL01DvMcOOQVlLyVg0
	 aw27Pn4hVr0am8qWkaW4XQ6AX/nNIQBb2tUP4Zwv1ZcACTigO8l3R3P4zyup0qhCd16CZ
	 2YzncqmRcuKdudstgqzzQ0aZSFAI8hXwAGhBuD7dHU71Q/vkdz6AKV1LRd4mIidBi5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="F5D8LVl/";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="h2n+I6g/";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC0606D83B
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 09:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CDC0606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=F5D8LVl/;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=h2n+I6g/
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793956804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+RIYSJuCkjGJWvn9kpp/Ob8ans1MXDZ31RXyzn2feM=;
	b=F5D8LVl/3SApjCCnn7gjsfFA3kDUgE5L18DqzS+K0mebjCevbonA5Ed9fnS2fbiP8gUg9/
	q5XKv9obqayddERdq3P4Nkbg8mH8zmGyK11IhRogQfwERJi7WsZUQqGs2IsMQ6lW+j+u//
	9aau22bSMxKR8LbV6qaU3tR9+WR467+aE2sAyBCvPty6k42ozCg1uZEfVrJQLEBLNPggyl
	tUwuvRwb3dB2sIMgx681lxEyR3qxZ/U9+uBqUluR9oozFgyy/YA+zE+CDP25bZSsNSWPVz
	NZKjkf7Vn4iZ+wHFwQ1ocVjwn8PkHOgkxAYSmZcSeWIvr9blKY9wIPaCcMYQfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793956804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+RIYSJuCkjGJWvn9kpp/Ob8ans1MXDZ31RXyzn2feM=;
	b=h2n+I6g/N7m/SKZ26rk/pwtV7u20l/d0Lbu6WlZpHB6YwrerHWYj84m1uiXKAOgA21Hawb
	RBBpuHxGBFzOiMAQ==
To: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@amutable.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	linux-rt-devel@lists.linux.dev,
	debian-kernel@lists.debian.org,
	linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 09/10] Documentation: Describe kconfig-checker overlays
Date: Fri,  6 Nov 2026 10:19:21 +0100
Message-ID: <20261106091922.7560-10-darwi@linutronix.de>
In-Reply-To: <20261106091922.7560-1-darwi@linutronix.de>
References: <20261106091922.7560-1-darwi@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 Documentation/tools/kconfig_checker.rst | 57 +++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/Documentation/tools/kconfig_checker.rst b/Documentation/tools/kconfig_checker.rst
index 73717ac56ea9..152bc0c634ea 100644
--- a/Documentation/tools/kconfig_checker.rst
+++ b/Documentation/tools/kconfig_checker.rst
@@ -18,8 +18,12 @@ The checker can be invoked from anywhere in the file system::
 
    check.py check -c path/to/.config -r preempt_rt
 
-As described in Documentation/admin-guide/README.rst, it is also used by
-``make checkconfig``.
+An optional overlay may be supplied with ``-o``::
+
+   check.py check -c path/to/.config -r preempt_rt -o path/to/overlay.yml
+
+As described in Documentation/admin-guide/README.rst, the checker is also
+used by ``make checkconfig``.
 
 External dependencies
 =====================
@@ -47,4 +51,51 @@ The checker's rule files are written in YAML, and are stored in::
 
 The schema for these files is fully documented in::
 
-   tools/kconfig-checker/schema.yml
+   tools/kconfig-checker/base.yml
+   tools/kconfig-checker/rules.yml
+
+Overlays
+========
+
+An overlay is a YAML file applied on top of an existing mainline rule
+profile.  Overlays are intended for local policy, distribution kernel
+packaging, CI environments, and board support packages.
+
+An overlay may override fields of an existing rule.  For example, if the
+mainline PREEMPT_RT profile contains these rules:
+
+.. code-block:: yaml
+
+   rules:
+
+     - name: CONFIG_DRM
+       expected: n
+       severity: info
+       docs_hint: config
+
+     - name: CONFIG_EFI_DISABLE_RUNTIME
+       expected: y
+       severity: medium
+       docs_hint: config
+
+A board support package may override such rules with an overlay like:
+
+.. code-block:: yaml
+
+   rules:
+
+     - name: CONFIG_DRM
+       expected: allowed
+       rationale:
+         This product requires a display controller and accepts the latency
+         cost.
+
+     - name: CONFIG_EFI_DISABLE_RUNTIME
+       expected: n
+       rationale:
+         The efi_runtime workqueue is pinned to housekeeping CPU#0.
+
+.. note::
+
+   If a rule is generally useful to kernel users, please submit it to the
+   mainline profile instead of carrying it as a local overlay.
-- 
2.56.0

