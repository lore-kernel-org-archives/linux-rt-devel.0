Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E642310655
	for <linux-rt-devel@lists.linux.dev>; Wed, 10 Sep 2025 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494608; cv=none; b=owUAEV1O4j5ie19OewCDjL+Q+asrEdvt8BkvQD7XRJ1WRl7rchj5ja1a4l+M0R6hXM4VeZ/IcNlIOYFH9rx60LgVlEwQsAxpiSmDeMnV06U8mzxb4zkGhyRBwegRr1eGhk7/kq0uN20aVaqTLE5suefpJyOhX1a0pdcjvNfUi3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494608; c=relaxed/simple;
	bh=oIER+SSaWj5q2B/7maqY6YrRAc8TAtXtsVduNhMEM+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=q3Vz2t4pE0BOqCtq/K4jIqEhfzvt6O1q5EgFN8IGh/cB1o6v585BhzKKd4UoVKJHpg1zvLuhPRgsbCy58VHtbQZddBVARdA2XwCeEYiLKCipP1LI3bb4YWvs9eR3MrGR7Q+LFfl/isDRAtCsngh4if8Zh8kWTMbQAmBoHcUeFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GakCXapJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GakCXapJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757494605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fytt+SdLHUb8ufJubForkl+i4Nu4NalKZH6lY20wByI=;
	b=GakCXapJB+G2rdm4ujjDMDP3rb/Tu1SeZL/Hk0bkIAjJUKsJ5AQneTezKq2+2Qmt29vDVN
	k6n/FSTmay8reHd30N9JZI4EFvQxTV7+h5Afh0WwCHBjuy1uQoQbs7GTp6W1Nh7voV97RU
	hZkbJyHWh8148svXKJGdg7jGGBpechA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-jLmose9kMJ6YCZlOgUIh9A-1; Wed, 10 Sep 2025 04:56:43 -0400
X-MC-Unique: jLmose9kMJ6YCZlOgUIh9A-1
X-Mimecast-MFC-AGG-ID: jLmose9kMJ6YCZlOgUIh9A_1757494602
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b0422bb16f2so707579366b.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 10 Sep 2025 01:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757494602; x=1758099402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fytt+SdLHUb8ufJubForkl+i4Nu4NalKZH6lY20wByI=;
        b=rcWMcO/anWE24X09vXJUQtlBTDRP43TlJh7ZX2y6I1iJIBRj3pa/6lRUZY7EXsiBnX
         0X5ZyqwLoE9mA3CiHgHkq8miy/UVzQiWB0h58PvOyK2vCJb4ZACIdEOQFIlxE6rCTAjx
         d3ZCu1Mb4lqRR497CzyhaAnH8eMy/8PKDL0mYTVa6eedzQRF9+5wpkmts4RZjJNjRMOM
         GRcwhLSpyul8gDN1hpnZZvDFc7fRWRJ1nI8A+FVUfgqfGNo/datNWE2jV/ugb1I7c+yS
         fAeixAnpPS1L9YqPybttvq+NUwXuYWJViy4KiVmxThGhQ5CrBx1bdtypboNf1Z+/Qdpw
         DLDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoGyEp0d16+2Mj1tIGsAOqEe3dXm4B6F2qeun3wLlUy0qN4mhZF4YdBsyXKIpSnuKn2qoJuQm+xPgrYyXQ9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzS/WMrDC9bSi1sa1RoaZHUC9O44NwM++P3aaRRYigh7gVwhJed
	eZPaconZ//XPh2slxpDKmYEhRaYuccrW/ZaaJdVUY/LtBlMg2XuVczfQkrEflFxCiaO+ujZjbe7
	bJFqqQpPgp4TjkDVp0bEZaFVHuCjQ9ZbuJ+PLA5e3y+ts6EkU7zQaJsyl90HuFeoXHjND
X-Gm-Gg: ASbGncvyNuKjsznTMFxx9sPxBq82tZa9pshO8ZI6XS+2RoLEDeQ0/Xjnkrc3BiPIoP9
	PrTbCXZHPg3n0Ud16P9WT/ZAZoIkwHiGugPW3lBGj42GIcfEI916TMmFLYPSjGuEN0AuqRtvXTz
	BDkXW7IkQ1v+W3Iuu2/bL2De/j0wS456UHX4S6vUL40JYFuocF7AaARee3QNoBenp6o4LaAa3uJ
	TTZUPxADMss5Cnow2AwRq0wYRetKEfBBpKlT5EemUH2bd6wLtMuHsOZjN/FV0RcW6kktV4arbls
	MM+Gk3T3oYfF7UZ0sS5cMXoVHTZR8wRVY0kAXld43po14Dpq+Mz4cSsBw3rNxlLF5nDSZG7hKBp
	8i9Q+CDa4RCpsig==
X-Received: by 2002:a17:907:7e9f:b0:b04:6bb6:c91d with SMTP id a640c23a62f3a-b04b13c174amr1250436966b.1.1757494602168;
        Wed, 10 Sep 2025 01:56:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9IF0gMjbTyuyEkGfSe2kM30YiqJRhQOmvcAmj1Ufv8t2CRUzDLcv7hw2HV0ZOafNwmGqrIQ==
X-Received: by 2002:a17:907:7e9f:b0:b04:6bb6:c91d with SMTP id a640c23a62f3a-b04b13c174amr1250435366b.1.1757494601803;
        Wed, 10 Sep 2025 01:56:41 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0783046d34sm134309366b.6.2025.09.10.01.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:56:41 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: Add doc files on real-time support to Real-time Linux
Date: Wed, 10 Sep 2025 10:56:35 +0200
Message-ID: <20250910085635.47724-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8LfYDyoqueYmJDkoWYckd4U-aqXH_42ccsePJdkSX1g_1757494602
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit f51fe3b7e48c ("Documentation: Add real-time to core-api") adds new
documentation on real-time support, i.e., PREEMPT_RT. So, add a file entry
for that directory to the corresponding section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7175c38c6d1..e2782810d0e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21403,6 +21403,7 @@ M:	Clark Williams <clrkwllms@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 L:	linux-rt-devel@lists.linux.dev
 S:	Supported
+F:	Documentation/core-api/real-time/
 K:	PREEMPT_RT
 
 REALTEK AUDIO CODECS
-- 
2.51.0

