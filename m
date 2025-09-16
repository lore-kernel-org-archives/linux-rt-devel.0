Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDB624BBEB
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998191; cv=none; b=KTzIi8YXMxcgQpZHP5V/o7T3SQ5ERJZOq9ENNzIw8+Vr393qimfhAFDPq+bihPwPrGjAWk+NvSAeATBdHUSPueRS548RRlFI4HricIAEhXlG7Cr+iZcPiWyi/KnZKD93V9bJSp/Z3Re75L2z8/N6U5NDZzwdNVGExZd5NJwqvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998191; c=relaxed/simple;
	bh=slyVnZPzDDOXEcpF4QZOR3I7YB3yd3f7Gxtzb+FU87Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpbSRmJ8LwMjm8SZE21makvqfyPvPI+9De98y9uyzxSJZJFllAIGcYrKcsDfivTtMmtPSHjOmy3q8aLVjxBKM/U/kU/3Ii/vpb/wZ5++DVQTwySLW5c4M0cT3X8/KxqG3FxFVejXhwf41cjslcQHBdOxfa19cysfQn5PHhMijT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCVUVlQ5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCVUVlQ5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26763bb9a92so13926985ad.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998187; x=1758602987; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlYXyo2uZuFo7JhGyy9UUCXJlKeDR2CbpPIjqr5RgpE=;
        b=eCVUVlQ5IlgugLA0zdu0Y4wyAie6vqcafBiIiHshG0UZ/ERs8d021l2Vc+jo0y9G92
         m8FLQf0/ggpVY/956rbr5B5B4WGyM0eQ0Lne1jFyz5IIRBb0gHhze/hA26TvBK7Lnlnv
         CyvyGhMbsTRIA2+JnvRxeeuxxzJ9e1HOlH8TzWzm6YnMRvZNLcFWGmEm+oyCvk5JbC3l
         x/WdRwkGtquhPD0z5T0mlz3PocI5nXFwxv9WMAYokUnZ9zlpjuoNlq4TuUdLSOAKSPT1
         TXs6gWusgWsm7YYKvN3GijthpINO06w7XriNDhde0MlyZGGVEfvoy1KjhYxTDuu1swdT
         Y6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998187; x=1758602987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlYXyo2uZuFo7JhGyy9UUCXJlKeDR2CbpPIjqr5RgpE=;
        b=Sw21eINX25mAZs2Dxq17qb+eDr2SGwUIjWqf4rLoDOwUPsZndnqta/vZoaYgo78Lgf
         C2rQPiShOhKGm4pj+Q5zWowvFedpATbC2MXawh3HukTHFOWVdZp04moavj3Z7eUFCTI6
         BERN4JxgF6VR8O7C9TT2v+rEf7yV93xNziEoWVGTc0XjZkHZoeUyOmIEnQT9kqDtvB1w
         h1ruA2FImmp7SbC4iuPK45VRkLJsR898kYKsVTHWDsBEKhv0EmnYV1OUvmlQOpPLeyzc
         tcInW+3Ak0qiJKX7D4TVl1dfguJe0jkkvYtkXfFJ8HHa0DLWPNFsESGuIkaK1iBJjbNT
         lTNw==
X-Forwarded-Encrypted: i=1; AJvYcCUL9wNnXQZTsKnaq174HtqwSl8cY23B6nIw5mHvQz3XweKNHTfKxYyJfdXXUnRjAAlB6upmyA9TREnFAeeDiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUJXKGSPcwt4gwd4wxjkSCRId/WGJSf5eV6imjCWL96/agxGeK
	lNjsrCyBgtAi7zjN+RdRuGmuv//bAgvwD1FIsTEG0qCu8G+nbaYYTrO3
X-Gm-Gg: ASbGncviacaPkwkIHVJzkYx1XYb5sQftLu87B4sAq74sQzrnyezb2S17ACDQLZGqdqS
	yI0XoLO4iXHjGdPHLwzE5Y1lKpVIY8P59m6zTG+Opvs6h0Ef6bb+VQSt8RO16sVTIdXcKN63OAl
	mSddzkQvdlHUECgWPKPdcxrEM4eKc6hCNeNagFRfRKo4NVcen7bTqjPkm1BAsG8qOu2tGMcX/0v
	uilOMRy3yuWAhYEPfg24Q7xXmQO2yWG6EV+NMXADkk5blbbu+aE1iME3Al7zCIP0hMRtzDOgjvc
	VrWPVM0G1sTVhQDolKA06Ut+gEOaEvwOSX4CUuM6VuTs6m49H9IOimmVhGG6D/Zb9gXJZ4obrZG
	Fv6Pmoxpj6A1mlYjRncSWIak8au9Cm8OXO+GxlQpIrBXBYXNa2Q==
X-Google-Smtp-Source: AGHT+IFV4zbzh4iycIfH4WDU92suC0bCanMglT0Ogl2GwpwL8kM68NHrYSygkh1AIkIcAzvJhqwslA==
X-Received: by 2002:a17:903:2f4f:b0:24c:99bd:52bb with SMTP id d9443c01a7336-25d267641camr179941415ad.30.1757998187203;
        Mon, 15 Sep 2025 21:49:47 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:46 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	"Toke" <toke@toke.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:35 +0800
Message-Id: <20250916044735.2316171-15-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: "Toke" <toke@toke.dk>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 0ac9212e42f7..4a0f465aa2fe 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -1993,7 +1993,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 
 	ieee80211_txq_schedule_start(hw, txq->mac80211_qnum);
 	spin_lock_bh(&sc->chan_lock);
-	rcu_read_lock();
 
 	if (sc->cur_chan->stopped)
 		goto out;
@@ -2011,7 +2010,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 	}
 
 out:
-	rcu_read_unlock();
 	spin_unlock_bh(&sc->chan_lock);
 	ieee80211_txq_schedule_end(hw, txq->mac80211_qnum);
 }
-- 
2.34.1

