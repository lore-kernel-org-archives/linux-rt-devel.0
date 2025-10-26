Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333532594B7
	for <linux-rt-devel@lists.linux.dev>; Sun, 26 Oct 2025 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761453854; cv=none; b=ZCvZicnyTo/okn9OiUrPvfuyo6rBPSv9N8F2MPo6RPj7CzG1i/M+YOl86ctaqiP8mFvdHYyw9sDq4zSOKQphmDaQ7zC2cabzuhdJXKyoib3szr80OMw8+QnEXwT9J78onBkkyspuhMaO64oE/rT05F7OzXLLfDiaknR2P98ZdHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761453854; c=relaxed/simple;
	bh=w4Q+yHhJBasAdeSXBOcO67FD8hR5fmC9dO9uLZoDllg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cl5h2VJYlcblGKA6kK2bZ+q1UUTJ9vVfgQ1ACBtsGJS2c/5Sk5IYcYq30kBOIp6UdVWpW4oml1lQzBF5fq2K3KpHfcJtypzvIiZh7GnPI0/0axYpvDjcUAGmJgtraU9c6at1BBG66lx23v4hwfhjhjVd25uotOB4ofTVsVuDUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiWr2aj2; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiWr2aj2"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6cf30e5bbcso2096356a12.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 25 Oct 2025 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761453852; x=1762058652; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX0ni6H4pbjiWrv/AnHeK1axe/PVUJRTQ2U0GTGwYuk=;
        b=GiWr2aj2za5hg26jr34E9vdnD4UWkAUibSNrrmVrLmJXqs8TJcscfSlHXP/zFvywS4
         PQwmlsmm95m2+sDm6Bs6hSB1Ejj8NBF4NBS4DnR9R33+Od6/3wuchcqYbcjuH9DTeotg
         lmrM1dS72+u+ZGE2mfXHWa55TlrfyhhM5YLO4jAt1Nj719zPY6USy8FK2prUSxXMU2FW
         +SnTF+gdGNz+AeDGFvmuzGLWsRq/sYF7nBrLaV+ACZUzOkyzRcBIUgDIQEa7UueYO/x+
         U/OEJRDnl+Chh7GSSXwn9S8nwS4jksXhPs7jKFLnJc89jPiLsil6nLPEC1+2wjLDa0mD
         HXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761453852; x=1762058652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MX0ni6H4pbjiWrv/AnHeK1axe/PVUJRTQ2U0GTGwYuk=;
        b=bZXTn/KtK+X0C5byFiF/DIe6cXqIFch0RZ2h+aCL9tohNF6U2dJIYFrlN3UpkUmwQ3
         8Xefb48u24JuCm8xIzn/KmHMuKYV0WEf9bqVtiN8MI4KofNYkkHtPHx8/SFHDkAS2vIS
         JHjTHiSjz2+GVySaLh+GaM7CdeXJPZuOls3UP63zRdkCUmod0sDiYT5AWgTItutqNjBn
         2Ege36rGXHk/5ENjUVhFKmpntE8bVqGkTFRt6RBtHUJ9Rory8YEpHn92yaACESwO56jS
         CaozkTQuOTWc7y2xqtKEpdk7b/piDCAZyO3m/KWJFDlChn68Z+NYZTDJom/VJSfiEX6v
         nRAg==
X-Forwarded-Encrypted: i=1; AJvYcCWvnGl6VemvhPGNs8tvjh6QsnCebuUYW1its2nkGel2ucGXjTlQghkEZ7WyRJQyXnzWDvuu4tc3bZ1JJCNlYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YznmQcJTGMYkEuhYeilnfmeyRfnUXjUfH3Jzo2CAq4XHPqxkwad
	szXCUjfEoYELHfxRhrE3K3AhV/NPfLSliQ5Kh457HL/ratUqfrCulVzO
X-Gm-Gg: ASbGncsIWSg1XN0Mx9bo8Oh+q0s9Gs8lwtWMROsXUl2vBYIAYTmMgHU6BIt2ixJ2paj
	3UVTDREOmBGAHAYSkSYDAf4IC/wGt3/Cb3Je0Yr2bymEneEZnEQzoLFaEifBczs+fr5sra+hxGo
	v8WVvoM4i4ZEhZijF0Jb/MP6jIuNhmttFJ6OQOglkIoHRl07fs0jp1g5XVAcSm9PFtF5OCH1dJ9
	nZlEBtzYPEC8oasY+N6bJv5XOOYs5MsZeea4EDd/+h/vH/rWpHr8+U5J9g2mgwq/Q8agGEJyBuP
	v3Pga2GF8hHXoJE+KSLLD5852YGkUQLjRYbL9sgMRG7oPg/SatHN03gbv/S0G9+dQInyTUkNGL6
	/DUAkXnzwjhIG3oNeKkCHSJlP6Gclh+0jD4nP9K9ZvD3/S3AE6yATTN0orZAPaV9HFF8DY/4HCE
	z8g/tVl4K1qN1iOWkAr/Ec0aWL+g91giXgRUwvyPyztYac+/sX3A==
X-Google-Smtp-Source: AGHT+IFUy9nDaJV51/d03ANfLAhw0sYIOgZYfK93VgsR+kv1D2t1kjboFjQQXoUpP81vgHZLi1rddQ==
X-Received: by 2002:a17:903:187:b0:27d:6cb6:f7c2 with SMTP id d9443c01a7336-29489e050e4mr101688115ad.17.1761453852259;
        Sat, 25 Oct 2025 21:44:12 -0700 (PDT)
Received: from localhost.localdomain ([119.127.199.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm39315755ad.48.2025.10.25.21.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 21:44:12 -0700 (PDT)
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
Subject: [PATCH v3 2/2] PCI/aer_inject: Remove unnecessary lock in aer_inject_exit
Date: Sun, 26 Oct 2025 04:43:35 +0000
Message-ID: <20251026044335.19049-4-jckeep.cuiguangbo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After misc_deregister and restoring PCI bus ops, there can be no further
users accessing the einjected list. The list items are therefore safely
freed without taking the lock.

Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
---
 drivers/pci/pcie/aer_inject.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index c8d65bfb10ff..a064fa2acb94 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -523,7 +523,6 @@ static int __init aer_inject_init(void)
 static void __exit aer_inject_exit(void)
 {
 	struct aer_error *err, *err_next;
-	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
 	misc_deregister(&aer_inject_device);
@@ -533,12 +532,10 @@ static void __exit aer_inject_exit(void)
 		kfree(bus_ops);
 	}
 
-	spin_lock_irqsave(&inject_lock, flags);
 	list_for_each_entry_safe(err, err_next, &einjected, list) {
 		list_del(&err->list);
 		kfree(err);
 	}
-	spin_unlock_irqrestore(&inject_lock, flags);
 }
 
 module_init(aer_inject_init);
-- 
2.43.0

