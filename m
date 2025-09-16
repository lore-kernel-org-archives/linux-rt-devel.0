Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14A2EC08F
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 04:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998171; cv=none; b=I8abquYLE8QOq9RXiJUwXz7zANSFFAFl+BVNpncVMbZbWoHFjqpDdARrCHLxaqsQ3eDp4Sx+pytsYGcgHTpMS/46s9DDp5KRdrXBo93meOGJQighkFCq5aVIR0EUpHRtqs7VtmYmgQMTOSz7LSjpOwgHDYeX5QmXfiD8UFYtDHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998171; c=relaxed/simple;
	bh=+qvXPu8HTVeRFaubIyM3rQFPhKws6qzYTh9yka49uSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GP08UdGZF93rGugUFDSQJ8taz8XtIIaLQNzCoP7/bh6bOkbx+YE1SDy05ylAyecPJTcHjdTzMCmEZU9r+4PZ8nEby01P8bCZxGRq+S+SKK7IXfERVH45fNJlxGrSlSfUKg/PlnNqlxfNj3tCGMQ7gMqTvjCcZrsMmch/XWgt+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMdPN+0I; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMdPN+0I"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b54b2428fafso3219529a12.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 21:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998167; x=1758602967; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSw+5V18QQW1zrEulMj1oteRdmYU7Zw4RYS7vag/74M=;
        b=UMdPN+0IeQuMDBXq9IXJsc9SOu1oDznSxyTmBu1tOFFW6jdPUdjzb+r94wO3oHDsMj
         EkLgApkuT0spUtwpRLObJ52X8RkLU5Aanfa8mJHJk4Fcz2iFnatm3vWpWcHZqzCyMIHD
         8q4qGJHiooCvIrAZuJEpavWsPcF+5QpefbTAjHphPfmfgetpaJyiT9YZ6KfBHNBh9FYE
         SdnwfsiEHd3/fZ1LOaN5CqXOHa3vKCgyYvQ971BWxULwPNfhQ6QfT/KoNCCR2FAskzgV
         6XDKffAxZMymnoeMzXHys6PAohhjmxM3k2vt7QMUQ2nbLtDhGxQ1fjecexSOuFvn8ewV
         Tsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998167; x=1758602967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSw+5V18QQW1zrEulMj1oteRdmYU7Zw4RYS7vag/74M=;
        b=Y090Q3FUFT3BMa3D5l/3CM6k/YwxrnOl0PAjaUQKoGBXM7V9+kkQU38v/ZeMQXBl6q
         nv1ST8/9agbYYQeWlWeAWnn8g4oFbN7uRQI+w3D57GpquzEebCSnT1IbS7a99KT0jIiZ
         +thTglYUbkj0mCALZkQk42WvVdWMxAN+/lBpCaoNy2FKor3hFinC4YkmKHLbkqUnVtdA
         1daImL/V5vkFRw8tB6w4S4R3STgn2W+RF8MakvEni8zylTAOoHvc0aYxDw0bmrdrZ6Hw
         DNUybX0N+bIHKZYAa/FyuG9n+Hk5/fF4ybiOISZ6zIlyoGXVWymgdF7EpdzvMQVEaGgZ
         bE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUc3WJtIsncZ3zBby7QN4JJscZl148d0nq5YBoOMlqJq/9RzZc4Gm96k1pl9U9ZLvETiYCKiOQz6Yy8cvMzSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxP3xJEmMuVIZ56vnqN3Z4YIWOQf9fkA4KTUoSOSJNsk14viSSg
	WzEgihHZxAgF3OFYRjmNa+XsS1bCj816na/tTmLpxakUIPiOqPRkHP1A
X-Gm-Gg: ASbGncuZjHj2p2KbFXd2K/leYU6MLyKYl6rRQar6dMtSShGYkP9qUn5NUkq0yeXOGmM
	rFm36RyRnmHnNVU6UTPZBS4xCWhntN05ePRznL8gsVu8tsgPwjHbbigBR3iAi9ydrXmhbI+3SH+
	RsDjF2OStn7mjCzHbbc5P0xy5CtFmjoiUwo35qYR16wPufiJy58uADX72j1O+JBNkDaz/idbt7Y
	UE7JbRwQir+k7Zj5IPlgf56nulNGQuiUEsE77gMIO6+Ravexf/xH/1O57LSdhdlFKwKN1vxsfCy
	ML5NsvoHHcPEj9eCjCSN95tCDES2nrT7jJlG3WYUZms1vm+Q/oj6W8sizen/F9LTorlSqmPMOOk
	ymVdbJtzNKpxhT65A/SR8BrASSjcSPq4llxF1Td0=
X-Google-Smtp-Source: AGHT+IFoVKHWE4WmC5NQoAJgz5S3HoMpNrjT8PBpaSw1vdAI3yXeG2nG2SQAkLHZCeabG5ejGwx28A==
X-Received: by 2002:a17:902:ea10:b0:24e:bdfa:112b with SMTP id d9443c01a7336-25d289e9988mr159622635ad.61.1757998167045;
        Mon, 15 Sep 2025 21:49:27 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:26 -0700 (PDT)
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
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 11/14] net: ncsi: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:32 +0800
Message-Id: <20250916044735.2316171-12-dolinux.peng@gmail.com>
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

Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: Paul Fertser <fercerpav@gmail.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 net/ncsi/ncsi-manage.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 446e4e3b9553..6e36cd64a31e 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -650,7 +650,6 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 
 	spin_lock_irqsave(&nc->lock, flags);
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list) {
 		vid = vlan->vid;
 		for (i = 0; i < ncf->n_vids; i++)
@@ -661,7 +660,6 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 		if (vid)
 			break;
 	}
-	rcu_read_unlock();
 
 	if (!vid) {
 		/* No VLAN ID is not set */
-- 
2.34.1

