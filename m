Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0372EB87F
	for <linux-rt-devel@lists.linux.dev>; Thu,  4 Jun 2026 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540720; cv=none; b=cM3FsJFu3+2kLRL23AFYcDvjOJlg4svLtOFI8bFzYg6bnYCZsjEiSvtKAKJJbJSuVfntABBIHYS4SMRzyc1+E4baNlGn9KpHFzYrEBmvjv3vJ1tQpF9buHUq8v0W25IshexiRvQCBbRA4Y6315xqP1DSn482SAz1A6GIC801qJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540720; c=relaxed/simple;
	bh=IgUc5Qe80z/jUGLWABaGxvs/O/OI5c8g7nLD+Ltw+/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bN0eCZHjI+lKoYgyqZCSw8pR1vnPpFRZzNbAccO8/dTONFbcoaezLdxqQTZVxhP2/ZM9AY+cBmw+Me5Auvq8B0WTLufODHpGVcxRxARZPnJteNjhgUpfYbcsiIGrZLoxbgs/Mw98GrDrrUVphD4bdlOtj5podqsDK7Yx8Y3dC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnQWhPvy; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnQWhPvy"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-36bcbd7821fso74341a91.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 03 Jun 2026 19:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780540718; x=1781145518; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Jg2muu/RqGJ6FJ6mWO/tENjNo0VfGXgaATf3xERkFo=;
        b=RnQWhPvyWddj5KPbcg8wHBLdIG5NJNphsn9XpqtmblL2EoBatn9WkkeCO+4eCz9Yxf
         11nuwGwEx5YEDONHnv+0sJvAj0SksEomwt83himZAlewVzaudTCelHbfmALo9nIdwVxA
         Mjk/BHCGP39+hWAYWVWUMDb1T1G076rSmhvQYz4QkkwjvGCtkXf3CPOTz7OJwRI+Wzdc
         N0rJSWzVdomBalhwxv55aUIzlA0eieW2qIhc0EtzSwGnBDr3ey9RZiGbd0/rIYNM5omw
         WF0Mue2+pv/JqaimLexn0lQh2IoFrahmLp60WecKRa8XQkkHn+nzLmurdnGVFNCdqHiG
         o8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780540718; x=1781145518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Jg2muu/RqGJ6FJ6mWO/tENjNo0VfGXgaATf3xERkFo=;
        b=H3cFLX7n69kPoS0t02lLFPPpL1eWFuAyuMYrtfFe3fOQAhjHnOzZDKqh4Ppp6pfjxN
         Y9w8zNCB32TlXcJFsCr6MHgM/8rPnKNBEYgNTqGFrJacpElKRaFsU0GdWW1QBjX/rVl6
         Ji3HZ62owQIfBQdbupnpWfNgeHG6oc55XupIQEBAs6dQbv+oAgRLT0jo/oFI+ZL6d0t9
         Gz4jL4+6Ax3aD02FvJ3GtqHhLid4KUiWioINhW13iPi5yEY31F9a28TSCFvtp5Gnx1ts
         1yl94jb8bgkq58ZgwyagwxV+2CwNjgD4FORe+8hCD4nDKjl6L1zKlnQJOlovYlPJmjsX
         opLw==
X-Forwarded-Encrypted: i=1; AFNElJ+zFTY/v9zMqm2Yj0nbe+FBPRZBYeZ3xEMIPs+jufQ0nStZBNjDJxRwabeAmkYycW20lBt6hBoUA3RMSjVgBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGAWxCw+ryMo25G7EVAeiBSNiwoJX3kSLZd2V+2BIK0YqaELt7
	IEuJKU5vIuROhJyVpCzj4lK86OJF8tvv3b2gvltPChlShunUazsCSjNR
X-Gm-Gg: Acq92OEY2NELWGJQUK9DKODmK+OwJn6qPGZYen/mI1zUVR53yH3hb7DEVMfSGbn3bL0
	v6h4RTxanDeSAirJH3vhZ8B5KgpzuKedXMCILScjd6zyszSNJ3vmR61rE74YaIRDqFXb2XT63Ey
	WCGgv1nomwU+e94M7dvfbCaog/Z5sIIkyRw9ptuOS14BfrQzQoi+hyAsquCZTKJ7rm8G2xjwNGT
	22Yh9BaxWXEs1Efsq2/Scz2BvudfN2vhjYIc6PxJfBCiQk2QISUYqLXqozUEboIhUTr0IFkhh3k
	byAEka/9KPwOtOs3uIoHYksCRiHDItkrDpmMIPe4UJWZbAsY8tH7XoFlthYiU46kw49cdUKOVTf
	cKmRX4NuCuM+J6qxi7HA+wGJkjfJsxjCTb2SBejnyM4lx9T1nPKwHI3SobWLA22csNR6vDrmZHT
	wKbwmUWxMzwOi7HSd0AMyYsgnYtVxD2JhrQHQKTiVoSlGBh+tNrtnHpicYYQ==
X-Received: by 2002:a17:90a:c2c5:b0:368:9da3:c496 with SMTP id 98e67ed59e1d1-36e335db4fbmr6149440a91.24.1780540718488;
        Wed, 03 Jun 2026 19:38:38 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6dba8573sm1253072a91.14.2026.06.03.19.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 19:38:38 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	Alexander.Krabler@kuka.com
Subject: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when compact_unevictable_allowed=0
Date: Thu,  4 Jun 2026 10:38:10 +0800
Message-ID: <20260604023812.3700316-2-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604023812.3700316-1-chenwandun1@gmail.com>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

compact_unevictable_allowed is default 0 under PREEMPT_RT,
isolate_migratepages_block() skips folios with PG_unevictable set.
However, mlock_folio() sets PG_mlocked immediately but defers
PG_unevictable to mlock_folio_batch(), result in a folio with
PG_mlocked=1 but PG_unevictable=0. Compaction will isolate such a
folio.

Fix by checking folio_test_mlocked() together with the existing
folio_test_unevictable() check.

A similar issue has been reported by Alexander Krabler on a 6.12-rt
aarch64 system. Vlastimil suggested to check the mlocked flag [1].

Reported-by: Alexander Krabler <Alexander.Krabler@kuka.com>
Closes: https://lore.kernel.org/all/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Link: https://lore.kernel.org/all/33275585-f2db-4779-89f0-3ae24b455a67@suse.cz/ [1]
---
 mm/compaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b776f35ad020..7e07b792bcb5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1116,7 +1116,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		is_unevictable = folio_test_unevictable(folio);
 
 		/* Compaction might skip unevictable pages but CMA takes them */
-		if (!(mode & ISOLATE_UNEVICTABLE) && is_unevictable)
+		if (!(mode & ISOLATE_UNEVICTABLE) &&
+		    (is_unevictable || folio_test_mlocked(folio)))
 			goto isolate_fail_put;
 
 		/*
-- 
2.43.0

