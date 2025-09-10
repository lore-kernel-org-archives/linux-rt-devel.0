Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8D2BE02B
	for <linux-rt-devel@lists.linux.dev>; Wed, 10 Sep 2025 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494749; cv=none; b=ehw9b8CLcYhs3OV4pIhTrIzyccjEiNoBfyfFQxz7SJEVZwcTxB84/VObWFNqLTndaq3mgTVZPE3GZxbjJTd8nsXfubQaC5vuwmp8aHb/cLbcO8leqxXB4Q0oWmumDeLKpFrwk8COWbevga3zmmNEeiTaWd7SSJZNQ7fEkqP6h04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494749; c=relaxed/simple;
	bh=qVUqCiNWKhbm4OJQ/h1GXQ4Ue76QXxYJE1ZLypTGFuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Y1gFaG49PX8GQSDjOsfYsB+H6elRux4+qG+7ZXmEPjYr+JdpE+uBIyvOoXS/1fEzMXLy+BOmP+Bzy956s2edGTv1H3r0RB3eKraEAfp5Nsd+miccxSHqYmXzPGkuHt+NPF0Xu+Ot3cEoRBQ+W/i0GvgPCdgC52zz3gziwpAYQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJO/JRsu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJO/JRsu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757494746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YbNpi+kDNBgUr3iCBEGx1sOECaER/m1rAGG176HSF7M=;
	b=GJO/JRsuuQuv7st6ZmT+Cv5LdPqNLgCOhnoz/7BdCuJM6EI2FRsJl/1v6wmvmRYHLXanRA
	wyn3hbUMJrXeKfZuQxeq+lgShl6/0kHUBBlpWBgU6nfD90+IUSfKQAyeP1QSrSdMrleWWT
	y/HGNQlkaVyd9kX2hZNFvAPA+6gLnmg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-sT33hkQ-OrSiUoBsu_rb0g-1; Wed, 10 Sep 2025 04:59:05 -0400
X-MC-Unique: sT33hkQ-OrSiUoBsu_rb0g-1
X-Mimecast-MFC-AGG-ID: sT33hkQ-OrSiUoBsu_rb0g_1757494743
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-627eaf68bbfso4444325a12.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 10 Sep 2025 01:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757494742; x=1758099542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YbNpi+kDNBgUr3iCBEGx1sOECaER/m1rAGG176HSF7M=;
        b=v7A6wqBAfqR1GnDj5XhpVaNdLgbsrHNDbXwApgaOdg+MpMTEgGhqbzpifljrlJvYnm
         1jue7GMEBWTFjaebJ5yD2bwpLfYWEEa8AUwdfbU3ID2b7NjWdYuLbxUYLepLT3p3WAmw
         0N/2uTDcD2CrXQKrOYumQ3HX4xdFWy27pEIlzNLHBCP5dpCeM9L72TMT/k8cZoAlnGhd
         dwcv2Jk6c9pG4NlIHvHP85YVhfKjXzxmG5FnfDHYQFloR6M5Fq5mKlno5+lQhuilSUhB
         PorFkcK2x0XhIZqH+pzqkNnhFgFnAjG902/4KMfJJUXj9leiu61b1WPUkBY/Ny/oKKP7
         VFCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhmxyLkxqhyq3vTDn3wwpiu6BX16ioQYiL+7JkNRpSzNLW3AaoWsZhxKMxBbidB/eKOJjqOwiwHrzjUxnusw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaTwcFM5ZeZM5OHMv5FwdKPGjAaJ03zYo45g6m0qQTxQ8Yh3bU
	pq5LFUAcdWoP91oZVK7Yw0EF+KNAx4lSbKTntCCE3IUSROuROuVLK+uJRW/WFlnsPWMZTPhITUq
	cN6smchrqvVkaxB7TYpD2AwOtEG98Mikp5IgQbJcH5PStG0pDGf93uAGNYKxUKGO/wiku
X-Gm-Gg: ASbGncs5uKznDoqhV3mWcGDlvWToErgJPcfB1RgyP1ZJ6DUJqNvcC9O1Ab891XKwcqj
	9mkKlm9NfQLXmdW/iOrtV293VwZJqRwEcGV6yD3YHqXeKgd8OLUpAoGH7nPDxhsbSbaUSdUIXcw
	GRTKpquin6Ut6b9UF3pFgn9GmivWtjUtktK562hKy0U/PkGkpnXWDq08VbuEJEvpSnY78fHayZT
	5ptNPr/WsjWeKUdVN7b7b93BzqmOdHYgQL9nyiGXE46MzF7kajiZrMlwYUAluD/mCcLoQLhgXUm
	PymRdFeiR++3KdpUnTNvvtwk6Hjb3B1Z/yE8kzhoCOorjuBbZnU4YPyWimO6GczYH9R6wvKSGc7
	6NPL6ot+CTOtVUw==
X-Received: by 2002:a05:6402:1d4c:b0:62c:710d:5600 with SMTP id 4fb4d7f45d1cf-62c710d58b3mr3918127a12.5.1757494742447;
        Wed, 10 Sep 2025 01:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIhjF/hQzrKDBiBG++LNsoFWIGNfnxMPAxlcabo5++O/vC/iz8XosvW+jycdz3EyQro8e4TQ==
X-Received: by 2002:a05:6402:1d4c:b0:62c:710d:5600 with SMTP id 4fb4d7f45d1cf-62c710d58b3mr3918105a12.5.1757494741975;
        Wed, 10 Sep 2025 01:59:01 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c0123f35esm2792862a12.32.2025.09.10.01.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:59:01 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] Documentation: update config name in real-time architecture support
Date: Wed, 10 Sep 2025 10:58:59 +0200
Message-ID: <20250910085859.47818-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5nHNX1_If38HCu8O-Qr6uhpVAKDqeQSEh-yXQM4cUWA_1757494743
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 14ec35ff5786 ("entry: Rename "kvm" entry code assets to "virt" to
genericize APIs") renames the config KVM_XFER_TO_GUEST_WORK to
VIRT_XFER_TO_GUEST_WORK. In a concurrent development work with commit
f51fe3b7e48c ("Documentation: Add real-time to core-api"), the
documentation on making an architecture support PREEMPT_RT has been
included referring to this config with its previous name.

Adjust the documentation to the current situation, and specifically
refer to the new name of the config.

Fixes: f51fe3b7e48c ("Documentation: Add real-time to core-api")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 Documentation/core-api/real-time/architecture-porting.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/real-time/architecture-porting.rst b/Documentation/core-api/real-time/architecture-porting.rst
index d822fac29922..3062cff0e5a3 100644
--- a/Documentation/core-api/real-time/architecture-porting.rst
+++ b/Documentation/core-api/real-time/architecture-porting.rst
@@ -35,9 +35,10 @@ POSIX CPU timers and KVM
   POSIX CPU timers must expire from thread context rather than directly within
   the timer interrupt. This behavior is enabled by setting the configuration
   option CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK.
-  When KVM is enabled, CONFIG_KVM_XFER_TO_GUEST_WORK must also be set to ensure
-  that any pending work, such as POSIX timer expiration, is handled before
-  transitioning into guest mode.
+  When virtualization support, such as KVM, is enabled,
+  CONFIG_VIRT_XFER_TO_GUEST_WORK must also be set to ensure that any pending
+  work, such as POSIX timer expiration, is handled before transitioning into
+  guest mode.
 
 Hard-IRQ and Soft-IRQ stacks
   Soft interrupts are handled in the thread context in which they are raised. If
-- 
2.51.0

