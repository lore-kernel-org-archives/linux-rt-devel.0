Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CF27C869
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 04:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998182; cv=none; b=BxiE8tieamuszBrvrEXqJt0moAPj8P5lwCE+CEKwFfMccWoySMaNHasMLRyeBKeLQGvOEIe7QEIG8naYcpJeO6ZS+TOjmowEz615wyEQD9B4QUh+kc8OglHb7+WwZ8l22ImEBGwkQkcwJ8YnE43XprqqDye4MTAVQJT0Yo80Y8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998182; c=relaxed/simple;
	bh=xZie7XPvdT38eYIBnvXACDOKlp4uDfFQ6p8xkwCAypA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YSYGK0nUB5cW/0ErqRtg6+cPplwjj7OEFb2Cyaeu10YOC5mVE5mJoY5yH7Jef+bIwz/m0wIzxtEvVuwNO+elLa/eI8OHzkGHO8yO5pLJ2MosoG9zp5ySwRtW+6sWWLpNY65onRJW+J4VTOAko2pxSW853R3CysTHbq4tGoS9yBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Am5NBX0V; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am5NBX0V"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2570bf605b1so48704935ad.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 21:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998181; x=1758602981; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tcedso9pzLAwLQitmBj+2+6wC4HZyTUiqHFeMdiOi8=;
        b=Am5NBX0Vjgobkb2mDjP3lxSt8aDJwewfmFcEJPPJsjufnciGLfGofP/ajAn4ojtb7d
         Obg2YUkxZA7VynJ2iVYK1Foe8/oJ3crCvndqg4p+gU+AsRQz1ZJiQzM4ASIqO95QMqv0
         42wg2WDsOv46iH8/6u8RcXRvOBegF/rX+pZndIGCbUS+0zE8MHfikHbMPbpcO0LPGmuH
         K3i59VcWrPOwwTJRhz16obbednFaJUwijHy08Pqp4mEgm4ucd6KS8lkHYlH0SqX3fpsC
         kaN0VKwEsUQB0rU1S3xLfejxRoM9B+DOR/5svVmb4CX8xT0X3BKLmreNLOxinWtW5EpM
         y5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998181; x=1758602981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Tcedso9pzLAwLQitmBj+2+6wC4HZyTUiqHFeMdiOi8=;
        b=J9cjdXG9C4+RGWArN+wI2+LJF1edjmGTfqY0ipS7DA+ymMG3FPB0rf5+fg2NRy1fL/
         pXyl5Du/JdH3awDOaoxNsLC8x85E7Vn+Ps2eE7yi81DCWR8NrFDXRtb8elhHr3/Zh2fn
         CrBOnocMApHYsWHJ0A1FvFNA+QFWxqsj5modRxr4g5Ru6qy14YYiApi5SKNiglVoEbGN
         Loo6F5Eu2KCGoQ2tkvgTHq7Wh7O8BbgSH9DL/DZ5wCh/rQv1d4RYNeK3XpE0Y1dH5Yyu
         0eCcazmFN62/Jzde5j3BVhOGhd/xEns/mWz/0+0V86Brnt3C446v6n2ghprw2oxqfQ9v
         WX9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYDAUFR6Fm8mknzd/ktFVh7RBixp5zn3glNxQJDk/2gb1brjEYVzVEsiV121+bYQXXVvIpJzIlZAkRIzawxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxbw8mGjY1lav1PjF44W8BLrq3Qp0cDARt2vhoiD/HfbuQ2rQOE
	d3TDIjFIhNk5npWQ9rIqI527htWMlVWYWZ4BzQ/feemrWpibd7mZZ01F
X-Gm-Gg: ASbGnctSU/QHlVb/vJFmObKlRLDexmn8X4hg26Y4wKxRf6t31O/anltOKXLB1Qjx17f
	LGaZcEfL4ha3aVZL6W/1eXgkalinzlzJqWPeUhMeiXfuoeRt/s+uOjxm0rjxG8aaQTBXv6Iu47M
	BX6OmYAn9OTd1auTwXfHOz2e1BRdZMJVV3yhKbtzqiKdXHRWyzygyHXY12lcG2y4lo6DPKluVca
	Ri0BJt4T2++N907j76eRpWD6foIJMDdrOmytSAhQZc61ZDJzcxeqdGKeObjFjcrauXYGsWL2X/g
	2hmWwd7XNwQpw7FkHgrN6dhZReuGj0jrYu38MYXb4uGp4VoQX+UhyeNO3QnFr8Qk5/7F1DVlmts
	PC6cVKJHoyK1XREtmexkVFH8wKEPyeBcv4zjIDjg=
X-Google-Smtp-Source: AGHT+IEk/DXYOCMhugqpymqTGh+KMlTQeAIuikssxOXlHLYZS5SBPJrXDrKkOxyomJ+DECodEM8EoQ==
X-Received: by 2002:a17:902:c40d:b0:251:a3b3:1580 with SMTP id d9443c01a7336-25d24cac4eemr191581215ad.6.1757998180587;
        Mon, 15 Sep 2025 21:49:40 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:40 -0700 (PDT)
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
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 13/14] net: bonding: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:34 +0800
Message-Id: <20250916044735.2316171-14-dolinux.peng@gmail.com>
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

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 4edc8e6b6b64..c53ea73f103a 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2485,7 +2485,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 	 * concurrently due to incoming LACPDU as well.
 	 */
 	spin_lock_bh(&bond->mode_lock);
-	rcu_read_lock();
 
 	/* check if there are any slaves */
 	if (!bond_has_slaves(bond))
@@ -2537,7 +2536,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 			break;
 		}
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&bond->mode_lock);
 
 	if (update_slave_arr)
-- 
2.34.1

