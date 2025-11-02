Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA8326B2D3
	for <linux-rt-devel@lists.linux.dev>; Sun,  2 Nov 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081072; cv=none; b=hmgfCZgjXcIovWVu7DoWI53bt2ex3qdeU7AlnkNzcj7RQxcubVj4B0XBB9uL807ctPffXmMNeivHFAH2Nko/roFaXZxSsCnNTjbDe90IvYq04LgW6MjjIr/WUZ9gOngC6hSuIUMeB5161TNPbrLMCmrXsnBHkj5czjAI2yFG2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081072; c=relaxed/simple;
	bh=SHEr//40zR6hLobNUNKlzHkrDggRl9UZzzbYH4lErwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xm1lLr9Rl6Efj+1fLyxuB6M21SxrI2K3f7Lp9DRyQBVhpXJDcW3gBq62W7Hqs4Z9es/qqFXpcGdMKF12Wed0m1eFYwiypnXn2CXaY0FBK6wMPjoqAgb0h1tmIPXsZ63HOA/f+MeBjGwWb1v3pIvm0sgw3BBuhbRtjiDpGoqdpMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzBck554; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzBck554"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso280830b3a.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 02 Nov 2025 02:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762081071; x=1762685871; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vMHdxPCuQYx37q4+PHeYjwUMtBpJVYVKStqHxBRsAFs=;
        b=lzBck554A3cBl86R7d/HsRJUanEMUqVBeMOkN/AZkjb31PGzPqGd5lK3kW8vgQTw/g
         tHXBnxJzgr5m5Vmjk+l8NjRDSiUmdYuMffPFz/LdUhkJPG5qtuHCw+s2crCKF1jtZxdP
         XY0BnNJAq2W4DHQMwxhBXiqodTmT9JZvtBykayJzW87jnZS3mub1oDl87hmRmYNHOCGv
         MrtoR7hvBDqj/4yt8mqVrxxWAcuryrOqViHjXeQxH5ECLWhyLp/PspaWbMfADCkEEq0F
         HypWOSAPBFAPxYPZosp+T5LXSiAXC9PmjjnIX28iLHEosLyUTWuRZOiZA6gj3/x3QbYS
         OVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762081071; x=1762685871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMHdxPCuQYx37q4+PHeYjwUMtBpJVYVKStqHxBRsAFs=;
        b=PGF8tOEklD3eRChOUo9tU4e6y7xWOhvE7LlDTrP11Eh9oivdREASxqO62c+zem0p33
         sc2fORUSYSDdROwRMANG1LkX7wDYRGzGEUWNzXVXpOqhFgPGtDhZHQjDIYbLnRUQtj97
         CWiVjBZMN14NEnu08pF05Ikkaflpjlgz0+uEDk8qdeDvAYonCr1tMHFmFQFCWdoe+OOc
         LIZJykNHrG4YWDekJFCokQICdmSmVZJlKWPixfXT0fww471+pj0tXETx9YmQ4u5SVFPu
         pKMYWyBC6BvJ/Oa4o9JjEjSb1miW1rLAecaMyuWm5d+t4MUwkYVBAmA1/WJmUxRdONgC
         qznw==
X-Forwarded-Encrypted: i=1; AJvYcCVdlaH7Rzz9rfpoUz8AwOceuzUB3tKPNhkB+4UjTh3xDf23JnK/CqySyh8f9+CH5JyJ1gJGVmUVJGWQhbkh4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx470jZvd2qe+qlRl4ipy+px2olJCoBfbgyXfzMdBqd+4F9Rk80
	fMhLX1RPUClS60wT9f7sk5PZv4DxhW46kp85jaZ/LaOTgBR2kQLT2aYm
X-Gm-Gg: ASbGnctvpJSMEYiDIv/0DvC6V/UN7PyYH2cXSVbhq1WZUzTWisdTgGPF0IxTBQ9sTat
	PmxXgIIEr+WVVpGCCNeRpuH1NnVnxh88A1cMb5PT9QFdBvur0ae/tDf44tjQ1NtAS853+AfJDFH
	GdgzJfsWOalMWPnXvaa9K/MyK1nCcfN5ZWhWfESZLW3FadKJxHT/BsNrDZwVJlucjoergzVvXq0
	TI9DGogmRUEKA4jT76RrBF9QK+wtk8AHz2GF389+65WQLimCO14E1/5OQHWLRBTU15OumaDuSIs
	XOKHcaQurioa5Dk5zgGpsfjIZ+Yfc/PIrC8SUPydYC2PDtd4PyAW0d0ToL7CybxbRdW/ecJKp9V
	Kyn1aWoZRtn8J1px2E6RTeZJmG08McZoCJHVbaXKYsM5zQkfxysOSvBKBhPDpnmiZC/VYtV0TKM
	qLugkSoDsNy4x6O53fGrOjHA0+svL4QadF7nXmP18=
X-Google-Smtp-Source: AGHT+IEsI4Z/8PcAT7j2pialDGZiC/BBy4ILYzqkSINF9zrcfL6KP/AE2O0RDl67g6y34Zj7lSoeRQ==
X-Received: by 2002:a05:6a00:886:b0:792:574d:b2c with SMTP id d2e1a72fcca58-7a7794c4f13mr13897182b3a.15.1762081070616;
        Sun, 02 Nov 2025 02:57:50 -0800 (PST)
Received: from localhost.localdomain ([113.102.236.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67999bsm7488050b3a.56.2025.11.02.02.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:57:50 -0800 (PST)
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
Cc: Waiman Long <longman@redhat.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Subject: [PATCH v4 0/2] PCI/aer_inject: Adjust locking for PREEMPT_RT
Date: Sun,  2 Nov 2025 10:57:04 +0000
Message-ID: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
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
Changes in v4:
- Reverse the patch ordering.
- Link to v2: https://lore.kernel.org/all/20251026044335.19049-2-jckeep.cuiguangbo@gmail.com/

Changes in v3:
- Remove unnecessary lock in aer_inject_exit.
- Link to v2: https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/

---

Guangbo Cui (2):
  PCI/aer_inject: Remove unnecessary lock in aer_inject_exit
  PCI/aer_inject: Convert inject_lock to raw_spinlock_t

 drivers/pci/pcie/aer_inject.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

-- 
2.43.0

