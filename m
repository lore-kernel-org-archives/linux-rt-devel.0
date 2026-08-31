Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5FC4B714E
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184555; cv=none; b=a98WNLHNytm9Pjj8rLtPrV34AFZYKLWXMbPrS2mz5JxbmWo6861bSr/hOy2iUFlncQ46Hg9gZo8y58PCc4zrAPL7vtIjQ5/BaW4b8AZQVH1wiBSFFoxOoi8qv1g4JaDXF0MW61NbuTlPSLXFnRZEpUAarXwNHMa3SYKm8Ht8yDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184555; c=relaxed/simple;
	bh=axzo8aJCFa83NYo0fuGpZ/KVEO6ZVD4PXl3FhGQolrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fodNH+y5/PNFUsaP/BpwNpkoob2bcVRdCp57czXSNKcGHpCT8mAGDWF1ZD9v2FevEHbn3YwIR9F2Y82IRh7KVWjLjM9Y5+rV+bohekrez9Tkg+F6KeWYq/6sh0bmciAVef+w2d8WUILEuYGK4C/4/GLps1KkDSAKAZFTdkeyqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAa2vUFU; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAa2vUFU"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so2529268a12.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 06:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788184553; x=1788789353; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jlQZGfunhhSOxluD44L3CBAxHK1ofhgstjgbuCZgd3o=;
        b=WAa2vUFU6YULvX8ocC45fmjTJ0douu5iG9MGuBEzjunFsOk3XNvowLJiBHNLW5ZCNs
         rnW1bK3UhUtj2AymBXkPgl4LhQQpp9y1eOHEJez4RqjRYJ17Bq94cxGn5WOCcXIxYrrH
         0i+Gl4CuZnsR97U5ctAAG5tQG4TTxx+SrSJcWJfvZ76gQONj7gd69JOCbKHpw13QueHy
         gv1w0x0E/MWbjQBy+Sx8j0DYUPgZm1+q4cvNdR3z0kzatLiHvSANXMDbitgMLhCXNCkF
         YQ18/YrWLbUzg71j5DUfmy2DDNdxyTJG3Z9glp0LNKbRlPjtpoTco1ozlD4bse29jxZP
         fNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788184553; x=1788789353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jlQZGfunhhSOxluD44L3CBAxHK1ofhgstjgbuCZgd3o=;
        b=U8GsAPm3TgHEeveKHzQxpTv7tG1Vt4EZ6U/+BnwgonDZxvlgeMtFtRk/djV61QI/E1
         obd8Qbs4bef97eGNdGnhCqrOWABPV+ltJycQc6Ml8e4a/9EQFzJVHObJzEyGv2WQYOru
         79KkDxbLkquWMeMWLhtQBoNWg0L8HlrzTdqWl0fDvYNTh94a1aaSgVNGPibmscP5Zrq/
         hXgn4l/KiefN6SoT1+yjYbxiHelPxfnVd2g8qsoR00Z0UkzQQ+s0PLkZoRQunqv6G4vj
         xDUdz7ozrX4JJRu38tqVH7XB8p/GU151KiPdK+xoNtnVbnB9nxjNPQJoeQrLMPfF1Q3P
         Hopg==
X-Gm-Message-State: AFuF++nPHxVHvYy/QbDWVGrpKS9FOzoXFqnYpSPRopbUTDSs8whNR3ma
	3c9xEfy5G4j6KPhsfHW5ZUcwTV6h9K3wlvUUtCSma+cXpsOFVyLoI1pF
X-Gm-Gg: AR+sD11QYe8XpFKT1fOXqC7+zU8tv5NRUtyK/8If7w8K1LBEMf87StG7nGzVEBkR0DR
	kuHAXnSFqwGiWpKCybn4IjKTzSlr1B93DWwSV5SZDG/tluUbEFPv+ARjNzQU+cyfKoaHkUQ0les
	lqWyAdWG7mSoIcQh9TpMlPZ1jxQSnY9r7t8xjZzvI52sFOynoUjeKaNbzRlBMjQlhJRcy6JxS78
	/ohB65jkMyXixQdHK/Pq3RQVJ9nt9uKUIWkOecfWSDlixyULyhTcd9Cq7uFSe59QHFDiAzZva2j
	NxSn01gesemSXzkpy5rES2eKHVcwSWwlPjpJqu7yVGDKH4rqKE29B0RNpjYcT1+R8nhF+ND+OiY
	hQ63pD+TaSqZcvzsuZXN8DWZBujH1+WiS0znGYm5ZlE2KIPgj4BjsSgDvLAL+H5Oh+r8iXIZOr9
	yf+aL5B/xhTnyl5iQaQRcwspgipQIVDPm7IYhYZou8D1v67j/WDcnZ4O3DOgNLuDxgAMumiwwdu
	SiUQmM=
X-Received: by 2002:a05:6a20:3d82:b0:3cc:b26a:7686 with SMTP id adf61e73a8af0-3d26784f231mr40133026637.6.1788184552749;
        Mon, 31 Aug 2026 06:55:52 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:21dc:72d0:50b1:2f22:32bb:703])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f3312676sm4204321a12.12.2026.08.31.06.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:55:52 -0700 (PDT)
From: ThangNN99 <ngocthang2710.1999@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	linux-mm@kvack.org,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3] mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT in kvfree_call_rcu()
Date: Mon, 31 Aug 2026 20:55:46 +0700
Message-ID: <20260831135546.9929-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831135150.1B4B31F00A3E@smtp.kernel.org>
References: <20260831135150.1B4B31F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, both are pre-existing and out of scope for this patch:

- The GFP_NOWAIT/wakeup_kswapd() concern in __kfree_rcu_sheaf() applies
  identically before and after this patch on !PREEMPT_RT; this patch
  only changes the PREEMPT_RT branch. It also predates the commit this
  patch fixes: alloc_empty_sheaf() has used GFP_NOWAIT in this call
  chain since the sheaves feature was introduced in ec66e0d59952
  ("slab: add sheaf support for batching kfree_rcu() operations"), not
  since 2a8bb29ec9b2. It's a real question about the sheaf/barn
  allocation design itself, not something a small, targeted fix for
  the syzbot-reported splat should also try to redesign.

- Same as noted for the previous review: kfree_call_rcu_nolock() is
  intentionally left untouched by this patch. Agreed it doesn't fully
  deliver on its 'any context' contract on PREEMPT_RT either, for the
  reasons given (local_trylock ordering, and now also alloc_empty_sheaf()
  reaching zone->lock). That's a separate fix.

Both would be good candidates for their own patches from whoever
knows the sheaf/barn allocation path best; happy to help test if one
gets posted. This patch stays scoped to the specific circular-locking
splat in kvfree_call_rcu() reported by syzbot.

Thanks,
ThangNN99
