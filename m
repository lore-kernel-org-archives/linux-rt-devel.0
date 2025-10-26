Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2022FE0A
	for <linux-rt-devel@lists.linux.dev>; Sun, 26 Oct 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761453840; cv=none; b=dLf9acJ9FLjHIU/SnJxPjhRyz3z6Xp9RHctK0D8jfxpbNjZC2WZT10sQ+VqJxRElBHJOCzht8Ns5Hit12mQOkrCmoN/m4HMjt6Jl68BisI1oj/x+qnZkzTdMR729m73CWTTAT4se7BN+I2RCfxIRMcErXg69dhUmiUGgohfKMMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761453840; c=relaxed/simple;
	bh=Aq74QMuE52R7WYicPBIBj8uAOiBzvycV/ZXDy6HTnQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p5Y4b8TWqJ8K36Ov0xmug2FPcDgydlx9uywnWKXzfzHN4ucxQXfJifURoZK3ZbEc/VwjcvhFq4tpQNrK0irHP+nnk1jbShCAegCDYzcrgZuKoJc8ZCsAfmlCreeHVQOHNtXzwMojXY+QwPntYds0LlL40g23t6L9CJ1XOYWK9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhcdxBWU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhcdxBWU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29292eca5dbso46774135ad.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 25 Oct 2025 21:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761453838; x=1762058638; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3QG/GQcuHlnsVtxELaSyj+sqLVJE39GY4SNmTDM2G0=;
        b=fhcdxBWUsv8NBl9wbdbjrYOMK45bnQsJElcLMUItJrHvfQ7ZrkfQh1bDPAk281VuLY
         mQ6NeBhQ0KrKgjD52cmVS8YcB2ukTSG6fq1QEElpB+MCJk0bqFGhQG17EOdUnc7VklYg
         proHKgTrk8LYl4mGbsbENlX4r/inNS+xJO4apoECCZJzTx6yZCipeDO3fjqUQkKzmF4L
         BFPtL2GQGZacoX1Mab2XZemUOU4GNccLF5q0vhHblbzEzoD88jFFsbMKz8df1B1eJBpq
         Tp/Qebl1SDNg7u3ilQzyTl7NKjO7RdnKC4J2u++zIoVYnyNqIeQx5lFWrjWejLRXzGe1
         uWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761453838; x=1762058638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3QG/GQcuHlnsVtxELaSyj+sqLVJE39GY4SNmTDM2G0=;
        b=fE6/0KGROUMoBgiI1waYQenG45gqeHnW0+169XNTDFSTtCeX6KPhtBPxwJZHgtEk3w
         SW5xqftr8zSigNDcDtZO5mdcxMUo4B6gBVattgMNMMDyFSH6ET4hx/2CBOtWinzEfBW/
         ZOguSPE4cPJqW3UQwKgPd6j0NfTx5nAlBANo6zfrb7jGOcqbAfk/dOPkCP9Fvu2yVMZu
         KomqS/5Y2hj2LRNPOL2Sh3vTPDGV3U8DAIiyWTKubQHjvNXAq7UNdvkCuNpV1yztF98P
         E514KpMM62+5QdonOUgQUnVCMDZC90mCm7LLJr5MGTyBjBUY35+FW9MJwNBCzPpuv2+M
         Iw2w==
X-Forwarded-Encrypted: i=1; AJvYcCUzjqX2Al1EXLHpY5YLJHl32N7VfO/e5DXeRIM19t+IphbrA50oEyjEswwwWnQfDKD3ifhDp2dfCFRg3dys+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzA6Detnqgkugj9d11NKveCky5bN/pGiuF24SVKgDWIC005tPx1
	N7hW/YPnHfzls6nFPTV+seI8feDl16UP0rV/+udIyioVE+QLItcu1pD5
X-Gm-Gg: ASbGncu+eYMFoCs7N7LmBFA2/LHzLL4cQirBaLcl6QnqeLfgOAO2ghtMY64ie5kNTMK
	JyijkDpoUMo2LeWsFn7cCzMUG7X3r42Q2bKuUs9v4J+0sMCRTBHqS+3lErA0tPEpe9F1kRo3n0I
	uYXr4/+1+OXvKZb+2LNX1cCWX9vEVpXu6TiOVDmRXg2h9QliS0JOsqv1eYrHZDmlcc4C+0lmzIa
	nH2aSUCZ4iI1kjVOZgsb9HHupf3Cl/5viwaz07OiM4uJ1qyp5jav8XH9Yf0r2G67VuDLqu1GR5R
	jPjX+8hapmY+39eNd5hsEVTNMBLGACs8qJ0E/YpRFblRWmDGh8VtL4NDSZfvv3QL7ZgdN603jjd
	jcO9qa37SC0evDdcePBe4KVPo1CUSq1ZeWuatCxMbOAjnYbOcs+8z7l+zfr34Jn9tr4meRtwziQ
	37U5MPQZXgasjD9pKA6JsNqLa5N0k5UsNB/DxQdjhKoYDJzKFMFQ==
X-Google-Smtp-Source: AGHT+IFB/FjN2j0+IOAja2+xRrNG+5H+gTFghf6JJ7KBtwsp4jcAYxVgOF8JlaL+XVkBPHYqSsE4lg==
X-Received: by 2002:a17:903:8c8:b0:269:87a3:43b8 with SMTP id d9443c01a7336-290c9c93aa1mr330667075ad.4.1761453837832;
        Sat, 25 Oct 2025 21:43:57 -0700 (PDT)
Received: from localhost.localdomain ([119.127.199.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm39315755ad.48.2025.10.25.21.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 21:43:57 -0700 (PDT)
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Waiman Long <longman@redhat.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH v3 0/2] PCI/aer_inject: Adjust locking for PREEMPT_RT
Date: Sun, 26 Oct 2025 04:43:33 +0000
Message-ID: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series addresses locking issues in the AER injection
path under PREEMPT_RT.

Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
Changes in v3:
- Remove unnecessary lock in aer_inject_exit.
- Link to v2: https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/

---
Guangbo Cui (2):
  PCI/aer_inject: Convert inject_lock to raw_spinlock_t
  PCI/aer_inject: Remove unnecessary lock in aer_inject_exit

 drivers/pci/pcie/aer_inject.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

-- 
2.43.0

