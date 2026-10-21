Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550387;
	b=omlX0LhKTMnSfgt0xZHaz8GB+n+naVKTFRhCZ0Wxw24N13zY04ncIu8DURfeWs646bZz
	 CgLk4VIFezhgr36sB34fF8YyOmp8Bx628q6uMsulZYX0DfwjD+mfrFmNg+a2p15ajTsrR
	 NZKuLoAvCES1p2pMAAELCMsqxEJVkIIhgDA8QHgKwmnLNCO2FTVy7S+2ZdJIGOV3zIQg1
	 hvoXVE/sGK8Tln9RnFsBumtOPmRvSVerPgHtBl77ZYBItOf+QZ+CS9CdF1kiT7LwytC/q
	 C+YcK4PPrzb9qpSNMyPFGxvwDSYatfYcB2ga2A3877zh4NW1cZdbQjPw9qxFVManCmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E3Lrkwg+RW4zCfUK1fUmtt4kQ0h3Wr8RlR2Q+IisBWc=;
	b=E+0T8llLy3WE5bFp2vUdReyYLwXLpEVNUGUyZiFK8+oZWXRJXAjeuNY2MWSrGDue94VW
	 0ce85wN4/z8CmfnPJcNDeIIyaSgADPU/vkMxqHYS8KxJBkEAOAyl3O2UQL27QFBPJ4Din
	 5P4xyJAqqMD1feiC3s7S3fQvpVIqeDOcKcZlKBpYSnqSl8y5cqcmYyHe/qnOZcX3HEajA
	 /HkngTTZhTQYETJyIFTLiDzsAFgxMi3jsbH3I6B/KhQf523e2crhsMK4XnEwG0S5hl0IK
	 ilwPaML9L0P+KHPqTKjwNGV2hkumD57vmoWFXEQVYPsNlDl1GztyHxbiMmGHOFA0X8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XF8FzqON;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCB2606A321
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 02:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBCB2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XF8FzqON
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9196d8543cbso2197646d6.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 19:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550386; x=1793155186; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3Lrkwg+RW4zCfUK1fUmtt4kQ0h3Wr8RlR2Q+IisBWc=;
        b=XF8FzqONP/zuHF0t9m+5XdFnApDpxvfGu0tcpnVO581QvjwUNpYgD7pLcYTBxpCReC
         P9KoU9CdHdBIVnpudt3TJJkzQev3xfUpr9Ta+JYnjaxX2Js2Ez1KtVtgz8kAiMeNm1yR
         w10WImdPRRmrH5C2O0Q08ULdo5gldllL2jtxHMishOGFbNrtUC4E3YE9rkdLhR0PosJm
         lTZJFNQfXpT6gIMMlc2oF031fZDE3lzvNb5WZsok4AX+bPiB7gNypRi1oliH6B+t8cQ8
         w5e6iSfLOghH2n0ajGRY+fENOeE/VSAMcQf2ZplqoLA1OlvvhfrHvljcJeyRgOaH5R6Q
         LEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550386; x=1793155186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3Lrkwg+RW4zCfUK1fUmtt4kQ0h3Wr8RlR2Q+IisBWc=;
        b=e6ptj0yycMfwuLwuHCmDk79fjqZ07S0kkksVK2Pn4/+XXuIp1Qf3fnxhMMzzbeXEPx
         +YLiK6oT9+2mB/C5hqXs3LLejTzM06SkLl50SvTkxPKnzbb8RU+wn8u+A7Rmmsa6nHya
         O8Omg6q1HfpuGlUoZouwTDWmP/YfSWgwZgg955j64R+YlKaO82FpsB7N2cclFEifZqkx
         3YlDh4PJO9eGdU1ffXZnHBy5Qtx3g9I9+8SZTJA+gcceHGXwJpKNmDuORZZLs+EFHlLZ
         WNZa3WCgD7YGbJ9hvdER7G73deClY0JQpGG6WUsouRx+V6skJdKA8PDelvGPgJCih/Lv
         7C6A==
X-Forwarded-Encrypted: i=1; AKwUvBxQ8OaxTwZRrhijPYxOflPlQlsm0WiUSxB4b3ShDvqTqHmoCxNfzxZQXLhTLxpI5wGn1ZUZY3lZWGUcN25h6Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYJmCP1VDLlMbLPaFWU51xIrjsibvKbicd0AOOpFrns0DyNGk2lu
	dlLF7ARGuAVwG+tfVnzHXdkrXm3CiyflaQdHXW2idksUT0R8QktZ7kwFwYENCDcogXg=
X-Gm-Gg: AYBFou0PYd9Mht6E/cY//nwyLJjv32h+tOsw5UqZdxpGy+eMlHsPwaTmxpObr31a0r8
	GTD/T4J7PjwLxn2u+gSTnUcePabtaQT5F4oaK4r8fdPOfQo6hhxE2d1meBLnCNXHqeHGPdNrTln
	IsbBD3yDQtjKgDX16KX89pCdKGdr+TpzHaTfbi4RgOcW/q8vV16pEgMkZ1b8OBbK0/DxW0h1RJn
	AF6zZ4gdX3DR2ByOm14KCJkNmcDkQpxk0E6+XuUG0vf508RX7mXnfZoWIropDStbbNSJ9YZSAv8
	lJHJJJvSSYw5hgKqqaiBZVhgXqVC0Zjv/vldQK5DB5K4Y+sS09c+mFtkjEK9v7XESA8QiMEEagb
	alDsooFr0Ay3HK20sM4X9JZCaJrrZd4NYItbJE+rENok3dI7V0U+t67vwURnrHVFdbPiasfOZgG
	fFuLZ3qAnmJituIWVo/qBLXNSQywKmDQpSLMXlQ/bFXy21WsTjtMvls/EJfNOJDcpMlTElG4qd1
	zEmChYtBeoqkzwm4wWAVTy/9688UgkNdMkDrQ4TEUPwUJ/oiUVOSTphQ2CgNGzSD+T3H3po4b9G
	zRllQz4EdETf1SwXp6X4NnKoEVtdAGM3I/SxRP+kEA==
X-Received: by 2002:ad4:5aaf:0:b0:917:9cd8:f26f with SMTP id 6a1803df08f44-91c12ed7e09mr12120496d6.25.1792550385953;
        Tue, 20 Oct 2026 19:39:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:45 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/8] mm/page_alloc: detect zonelist rebuilds from memory hot-add
Date: Tue, 20 Oct 2026 22:39:33 -0400
Message-ID: <20261021023940.1940971-2-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021023940.1940971-1-gourry@gourry.net>
References: <20261021023940.1940971-1-gourry@gourry.net>
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

The zonelist_update_seq retry was limited to CONFIG_MEMORY_HOTREMOVE,
presumably because only hot-remove takes zones out of a zonelist.

However, build_zonerefs_node() rewrites the zonelists in place, so
onlining the first block of a zone shifts the entries that follow it
in every zonelist containing that zone.  This can cause a spurious
allocation failure for a __GFP_THISNODE caller.

For a node with only ZONE_NORMAL, onlining its first ZONE_MOVABLE block
rewrites the node's ZONELIST_NOFALLBACK list as:

  [NORMAL, NULL] -> [MOVABLE, NULL] -> [MOVABLE, NORMAL, NULL]

A concurrent GFP_KERNEL | __GFP_THISNODE allocation can observe the
intermediate list, skip ZONE_MOVABLE, and find no eligible zone. With
CONFIG_MEMORY_HOTREMOVE=n, check_retry_zonelist() returns 0 and the
allocation fails even though the node has free ZONE_NORMAL memory.

Gate the sequence checks on CONFIG_MEMORY_HOTPLUG, which covers every
configuration that rebuilds zonelists after boot.

Fixes: 3d36424b3b58 ("mm/page_alloc: fix race condition between build_all_zonelists and page allocation")
Cc: stable@vger.kernel.org
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2daf358269ae7..c7125f6693574 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4404,7 +4404,7 @@ static DEFINE_SEQLOCK(zonelist_update_seq);
 
 static unsigned int zonelist_iter_begin(void)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqbegin(&zonelist_update_seq);
 
 	return 0;
@@ -4412,7 +4412,7 @@ static unsigned int zonelist_iter_begin(void)
 
 static unsigned int check_retry_zonelist(unsigned int seq)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
 
 	return seq;
-- 
2.53.0-Meta

