Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090F26F292
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 04:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998094; cv=none; b=ejE61yyyGosVWt+d3aLFu3eLMi+7rkzRpXXGQ0ndlTH8ucwbxteUzW1F9SrU/QbtFIfqvLS7CVj8zUPwCk3jFtd+DWHAittiUwODc+toda6R27YHcmaT1R3MLhi77RlRNRRRCtbSoebuUwypAJ4zhExd1ntTSZDLT1+zoPuVE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998094; c=relaxed/simple;
	bh=VmO2kvinS3A1vRaM0G0YEMkRq/84D/KeYXH2dYVRBxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ARR2Bl//ofqV24Uz4/7+n9U+oRWeLS/qi39hJa9disxLw+COYUNxHlZs01K5BvbaCQ3UDz/3lGCsVqtUXb0HhjA3MydY5x0mJdtDz6uXABdkfQZXASGmbC91Mfgi6iyQqfutH/Bv/3tQc7dyGxogSQutJe1Rd33JmOoHRaKn9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFF7IK4K; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFF7IK4K"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2616549b925so23780345ad.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 21:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998091; x=1758602891; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTEHvDm/IKR4tm1Bmr0HolxO+dzLmKu0Q858we1M/so=;
        b=RFF7IK4KeUhGQ7UNmbYA0SDaoi+cmPr0YtDoR8k4n+rqedivEpuDDOL6XeVLzFUH+E
         FNAEOwJjiveE45F02jRoxG+P7yoLgqzRDDgWrPCyvB3YwSjlps+uA7TlLFHVT1DxwfVI
         4ov/11nuQEH6+OTg2AikoGlrey62GuOXmZyiaXWfJp/v8PyzbTFN9XZoaREg9x24DbyY
         rl8AfkR9oiYXfDHd3e4/pGZp3bD3L6mHOVIU1B92X73kiRoecWU+De0tZD1iVgFQLSua
         EK9to7795NaM2XHw2cV/ywiDx/Euh5tA9htIIjJG4mgdvG9L099oB/ePCO6lUpDoZBgr
         HDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998091; x=1758602891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTEHvDm/IKR4tm1Bmr0HolxO+dzLmKu0Q858we1M/so=;
        b=kLYUDeJ4elb4AVflTBUJWD2tJ7ycc0OmO50z8/7bSWExgA/cRRW9HNXBCP7/s5QCTB
         GyL7SsBccdVZZrJ4BNd4ScK28oMhAqn9TOsiHs1bZNLJbFyUdZy2wxN9xuowIopZB0eY
         DmXllZJQw8YRBBRifxWdAn8bUb8S0JiZyPx4Qe4MRGsipPgOIgFn4dGkX9+ra3YU86nZ
         UwxUJU/ZH0yf+N07SBnYgkGuKpJEL/5uNaHeOZY/5sUPznzKCTV7LWol5FFlyjZiW01Y
         QN9Yec6hgAb5LeUmdYACLro3cIifyhkmtaBC7cGAUOZ6ACOdFhzGjp0o4VBt4OAfSKbY
         Qdug==
X-Forwarded-Encrypted: i=1; AJvYcCXJMwIFSgMpRUl4uGXGRp0qgWIjXUVefy3IayLGLYWxLekkJ6vvuE5aVc2rYBGOuHg0JvRKfkQhko540J0+nw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkYAB1nYYod0Wp+AJsOcX/p52ZMZacBU6FxVEeyh5RHbt5FX9o
	LU+IawlzWtHd3ususCrDK6SLyZZk8BSVGgUt14++rh1xz7H1RkN4zYmi
X-Gm-Gg: ASbGncsBNCn7W+WDJKga5ExArhiHEYHEw/X+vg1YXsJTAxxBAnfR0SpGqTpCS98glJV
	RbimTA3j3YKiPpM3/TGrNtWmM8pzNW9SPa7dQNEYYAVqPMyloqui2QaCQrKxT6K6gZ1Rc7oJQLQ
	qGbdPmRKyPfMw5w9bNnMvt/UH0No9rKLk/omJmOf5QdsG/xaF4UiNBHRYKwf/zFyfSqOasIDMPH
	PCbp9ihZpamxQW1dGLb4rUp4iKtxdroRjXiziGTVn6bXpwSRfsU4VXSdaHone2mPt1+cWcxx6TW
	jQOss0p8pOXNTBd8bgypJZ08uA3a0cArSXqc33C1/vjzyakQ701Q6akTFmNfeDi64oGMjSGdbMN
	Q/5OL2IqYPcJQSuTKY3pzH9KY3EbaFFro/dS6C/s=
X-Google-Smtp-Source: AGHT+IEF2ZVvpNxJJFMqOknMo3Fo0PQL8lIHY8yKPy5AwqV+Fi26iyI0GpvDt9oGgKPIwk00E+AHOw==
X-Received: by 2002:a17:902:e790:b0:267:95b2:9c0f with SMTP id d9443c01a7336-26795b29cb0mr59076565ad.28.1757998090662;
        Mon, 15 Sep 2025 21:48:10 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:09 -0700 (PDT)
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
	pengdonglin <dolinux.peng@gmail.com>
Subject: [PATCH v3 00/14] Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:21 +0800
Message-Id: <20250916044735.2316171-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

[1] https://elixir.bootlin.com/linux/v6.17-rc5/source/Documentation/RCU/rcu_dereference.rst#L407
[2] https://lore.kernel.org/lkml/20180829222021.GA29944@linux.vnet.ibm.com/
[3] https://lwn.net/Articles/777036/
[4] https://lore.kernel.org/lkml/6435833a-bdcb-4114-b29d-28b7f436d47d@paulmck-laptop/

pengdonglin (14):
  ACPI: APEI: Remove redundant rcu_read_lock/unlock() in spin_lock
  drm/i915/gt: Remove redundant rcu_read_lock/unlock() in spin_lock
  fs: aio: Remove redundant rcu_read_lock/unlock() in spin_lock
  nfs: Remove redundant rcu_read_lock/unlock() in spin_lock
  s390/pkey: Remove redundant rcu_read_lock/unlock() in spin_lock
  ipc: Remove redundant rcu_read_lock/unlock() in spin_lock
  yama: Remove redundant rcu_read_lock/unlock() in spin_lock
  cgroup: Remove redundant rcu_read_lock/unlock() in spin_lock
  cgroup/cpuset: Remove redundant rcu_read_lock/unlock() in spin_lock
  wifi: mac80211: Remove redundant rcu_read_lock/unlock() in spin_lock
  net: ncsi: Remove redundant rcu_read_lock/unlock() in spin_lock
  net: amt: Remove redundant rcu_read_lock/unlock() in spin_lock
  net: bonding: Remove redundant rcu_read_lock/unlock() in spin_lock
  wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock

 drivers/acpi/apei/ghes.c                        |  2 --
 drivers/gpu/drm/i915/gt/intel_ring_submission.c |  2 --
 drivers/net/amt.c                               |  8 --------
 drivers/net/bonding/bond_3ad.c                  |  2 --
 drivers/net/wireless/ath/ath9k/xmit.c           |  2 --
 drivers/s390/crypto/pkey_base.c                 |  3 ---
 fs/aio.c                                        |  6 ++----
 fs/nfs/callback_proc.c                          |  2 --
 fs/nfs/nfs4state.c                              |  2 --
 fs/nfs/pnfs.c                                   | 12 +-----------
 fs/nfs/pnfs_dev.c                               |  4 ----
 ipc/msg.c                                       |  1 -
 ipc/sem.c                                       |  1 -
 ipc/shm.c                                       |  1 -
 ipc/util.c                                      |  2 --
 kernel/cgroup/cgroup.c                          |  2 --
 kernel/cgroup/cpuset.c                          |  6 ------
 kernel/cgroup/debug.c                           |  4 ----
 net/mac80211/cfg.c                              |  2 --
 net/mac80211/debugfs.c                          |  2 --
 net/mac80211/debugfs_netdev.c                   |  2 --
 net/mac80211/debugfs_sta.c                      |  2 --
 net/mac80211/sta_info.c                         |  2 --
 net/ncsi/ncsi-manage.c                          |  2 --
 security/yama/yama_lsm.c                        |  4 ----
 25 files changed, 3 insertions(+), 75 deletions(-)

-- 
2.34.1

