Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956810;
	b=ROUXg4I/Bk8C/Ti7Z9idc0dnPFY2ApYuq9vV/M3d49Reyr7gDgem27aILi6gofz2frGa
	 4Qr4RTE7JsicIcEk6ORtLDGbBtitMDkN0FV+sst3oPi9DjIOg5piB8JS2wbcmk5aONYXA
	 4rB0droD/9pFdCJNmApQk0qerZ2760QMiW6vNKjK2TQHywLJTdIxAutWZd40NFgLzAbDI
	 cR4uA0PFtX1dNjZPfLyNIv2IpXUaFf1nqDW5NikuLvNUBEOA7RuH+C57YLafyeLJUZ+9c
	 hyiBT71i740shhQC26ILHDL4gmErKRB1P7Pfdl1MdEmQ+IucdKc8KwD+Y3uRy/nI8vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956810;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fsmJiYhHFp8PcnlPHKhucEhEpsHbUsMO9OOi7pQoBRc=;
	b=3g14dkNszMv+TTpjY7ULIloVACrJx6ahSVdL1OdWz5SYOL6i75a/mIpRvSADUIBkcMp2
	 cOveDW1mDoyTIma9slZrXOypLjNuMgjHGF7va6Qpao8YQ+ecr6qYIHF379E73UfSXMbqZ
	 kkdjadHZZILF/zKNrEX6frBv4EhC4wIOX30hjnJ41qvBzfq2l2j6XHkxUGLKIndG+mZur
	 Xn1wrhVnW3b4YEGvcEGi7rXnrtbpQKrCu8/uviqYFQ81ve6Igmlo6Mn2X1H6fqy/BdAFM
	 +yh452qyuHhUuNq0Vc6BZE79UaVdzTesrpIRksr52PUAdDo4iXVP2p5aWDOfJ/GiP2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="XR6M1S/T";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="7SHz/SlS";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B76B606D802
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 09:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B76B606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=XR6M1S/T;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=7SHz/SlS
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793956807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsmJiYhHFp8PcnlPHKhucEhEpsHbUsMO9OOi7pQoBRc=;
	b=XR6M1S/TiyCtgphzBSk9KSsI7wglQvugGDwImzn2uVytPw55X+QHk3efxDxuRdu+gx60lM
	y5X38P1rpXHtjb+xqUMbkxyyA13/DYmxoroR9TJvRKdktRNQXf1za0DAhEb4y1cs7PX/+6
	ybHmBIOw6c0HryLt9Tu8GOvECUAj1jqE7HgL+v9CouZvW/fvm8pSg6QC+J2YWymCRRZ9MN
	RXZN0GLDeruQzJXdvbcOiEJua7N64VnU7CUAkFIPTYO41XARaOOqYMjt0ohcz3bb3gtoJJ
	91k8g6VJROHOU+OAOz9LM06H3obW4i8sUdOwDj8pKbXEYFQLtceE46Q+6NEJRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793956807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsmJiYhHFp8PcnlPHKhucEhEpsHbUsMO9OOi7pQoBRc=;
	b=7SHz/SlSQBc0I4hRdVK2D7xO1u2w78O1ff/C4dCu2rmWKcVD+F1fSHmkSO2/7lAziUmi8e
	GXzYRxDXsbVV8BAw==
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
Subject: [PATCH v1 10/10] kconfig: Introduce OVERLAY= for make checkconfig
Date: Fri,  6 Nov 2026 10:19:22 +0100
Message-ID: <20261106091922.7560-11-darwi@linutronix.de>
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

For the kconfig checkconfig target, allow passing a rules overlay file
through an OVERLAY= parameter.  This is mostly intended for distribution
kernel packaging scripts, CI systems, and board support packages.

Document this parameter at the kernel's administration guide.

Note, the detailed overlay semantics are already explained at
Documentation/tools/kconfig_checker.rst

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 Documentation/admin-guide/README.rst | 7 ++++++-
 scripts/kconfig/Makefile             | 6 ++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 77ffe4dcb85b..b62689bcda6b 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -263,7 +263,7 @@ The kconfig build system can validate the generated kernel ``.config``
 against a selected rules profile. Running ``make checkconfig`` prints
 usage information and the available profiles::
 
-  Usage: make RULES=<profile> checkconfig
+  Usage: make RULES=<profile> [OVERLAY=<overlay>] checkconfig
   Available RULES: preempt_rt
 
 For example, to validate the current configuration against the PREEMPT_RT
@@ -278,6 +278,11 @@ selected rules profile. Each diagnostic includes a severity, such as
 Apply the reported changes as needed and run ``make checkconfig`` again,
 against the same rules, until no relevant diagnostics remain.
 
+The ``OVERLAY=`` parameter specifies an overlay file whose rules overrides
+the built-in mainline profile selected by ``RULES=``. It is intended for
+distributions kernel packaging scripts, CI systems, and board support
+packages.
+
 For more information, see Documentation/tools/kconfig_checker.rst
 
 Compiling the kernel
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index d67a23730259..faaa8c16ab03 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -126,6 +126,8 @@ testconfig: $(obj)/conf
 clean-files += tests/.cache
 
 checkconfig := $(PYTHON3) -B $(srctree)/tools/kconfig-checker/check.py
+checkconfig_overlay = $(if $(OVERLAY),-o "$(OVERLAY)")
+
 list_checkconfig_rules =						\
 	echo -n >&2 "Available RULES: ";				\
 	$(checkconfig) list-rules >&2;					\
@@ -134,7 +136,7 @@ list_checkconfig_rules =						\
 PHONY += checkconfig
 checkconfig:
 	$(Q)if [ -z "$(RULES)" ]; then					\
-		echo >&2 "Usage: make RULES=<profile> checkconfig";	\
+		echo >&2 "Usage: make RULES=<profile> [OVERLAY=<overlay>] checkconfig"; \
 		$(list_checkconfig_rules);				\
 		exit 2;							\
 	fi
@@ -143,7 +145,7 @@ checkconfig:
 		$(list_checkconfig_rules);				\
 		exit 2;							\
 	fi
-	$(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)"
+	$(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)" $(checkconfig_overlay)
 
 # Help text used by make help
 help:
-- 
2.56.0

