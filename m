Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B553D3322
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Mar 2026 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849506; cv=none; b=l7oM6zXMQ2cqxgqq4AY0h/Yu0by86K1XxREhspnIIWlb4sYYJDtuJgxYuuWU/t9dtpR89TYNwX0+OcCQetgoh4bA4KURSKyxEREZoMkbXcX4u1+1c4M79EpHnxBXPUNkSwfIwja5IUTl99NGZkgbeLxOn3a/9wcOfmQ89ABytp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849506; c=relaxed/simple;
	bh=M6sqFlUOY20hvUySeVxukwiG5GGP2gqCZbZV5+uYIu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gXviIV8Vr7ddys7hlcXS1tIYC+lJ0sJXMe7TmJzWKTlrlfa3WnYbA1EEUmEjsowdxhOtJIP9VsUxhp/eNnYsM3hf3GHbuBfmhrpCXIDtgaIFJ3ZzUFMZg/K32TslDD+IRrCDBpVj/hNanKTP2KzYeRsf423D0yaV7R7xHzm8mFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LoeOfq3O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoeOfq3O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773849498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5aJP2sYwPoJ8gxJ8rE0z1ERasHV1dH20ZyzElyHL9Uw=;
	b=LoeOfq3ORrav7+cB4K85dpguFsN/y1LCKhkO1yQe0Du9IAclcwn90tGBim68YcKWxV0Jj3
	Vef5S0ROcyjtRYP0u5NRqY3T3BDMalqP3kzUscSxsnZpP6GBO9UYjTqkH6WIErC/GUS1t9
	OazFrRbqGMVg/A5MGctVokPP9qyxp8g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-iYOSuGV8M9m_r-D9Fa2Dow-1; Wed, 18 Mar 2026 11:58:16 -0400
X-MC-Unique: iYOSuGV8M9m_r-D9Fa2Dow-1
X-Mimecast-MFC-AGG-ID: iYOSuGV8M9m_r-D9Fa2Dow_1773849494
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439bcec86dfso6237975f8f.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Mar 2026 08:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773849494; x=1774454294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aJP2sYwPoJ8gxJ8rE0z1ERasHV1dH20ZyzElyHL9Uw=;
        b=pVXRPr/QeJA0cbTIK+mo34VyHpni0QFMC+2Ri8my2Odss1ubM77UmqhXv5e1kQD6Me
         4ploh2QI+c+e5W7bJsKX9fHwiwaJNnzeabE9Sps03Q7MLnBnLDaRWV/NCOjqF/NvKSjR
         zCoyHZJmaXJLvCcIuhbaVG6kaavaRZAwG1ZKYe1WRbK6RgzX9mInVR/Spmg6VQmJA0IS
         +YuAWIxl0RhHqZ+WuPEw+w32oQvI1fvwQ5wO4eTLYaFnQTOAb2J/x6itrSSYo0B5gr7n
         gkq7iv9hZOutX0POJFpZxbHFOfAJDkELTxlCHDHBI/PN00QHot6JjLa5oWwFo/U9OhfC
         eONg==
X-Forwarded-Encrypted: i=1; AJvYcCVkwtJ71Eehju6HRSJHn6E7Ch+Qqogg6Jrd0SN00q6VcphFZsyK8wb3YcGaCgz4hlcpoKE35szYICLDWMLLhg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy71+bs+vWBdCBjcjGEsb28TcUQF9LW9sh9WejWCeBgwmzjVWSs
	D/RBJmNuAaTTCXJ+suUsgWK+jDshgPSOVdge9mElAIsrEDKsE3TgaHZz16+TXTdLfZR7Ro//wTM
	4mWoCVgbOY6HbGOUtn7/ByVMBRKNGjMXlFaM480xh3yeMPBKZ7aLxJQb9jBDPKIYrhvbO
X-Gm-Gg: ATEYQzzeMsvbiwxouLM5oy7c4fg2UPrTbfXtHOj2ecn64PtPkaObuzhK9vZlj+ufxnx
	zpLAcb5aGS5GAHxy+lanDTCvVBaJPAbYhX83Jp9a+o+tXzRoFg05gH+i1UTt8StjUVy0haAtBeo
	nQ9t2ZmIU+YieNJ4FIOMr8JWy662//oyzHENfI8LUJLhk5y12bR6aIXY/dl+5kVeCnL+t6JdoZr
	J6uQG/Bvq4BY1LHYr1La2Von+kIeJXdQtBzaJ/ok8FaHxIck2y2hp1FWpRwde89gB1q4hZXnsn8
	7uYIX9/9KlC6WMflQ8mfEbg1rD2BO2HNJ6dtPJtvFLLEHHeGigym15kzk1/8hTLpvlq84YipVAS
	yI/49184obU+PxGuEs/oubEENfM6gNff76dvVtta8y4E2qnxG
X-Received: by 2002:a05:600c:a4b:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-486f446af0bmr60719375e9.19.1773849494020;
        Wed, 18 Mar 2026 08:58:14 -0700 (PDT)
X-Received: by 2002:a05:600c:a4b:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-486f446af0bmr60718735e9.19.1773849493380;
        Wed, 18 Mar 2026 08:58:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c40ccbsm234105e9.9.2026.03.18.08.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:58:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CA2195A31F8; Wed, 18 Mar 2026 16:58:11 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Minxi Hou <mhou@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net] net: openvswitch: Avoid releasing netdev before teardown completes
Date: Wed, 18 Mar 2026 16:55:51 +0100
Message-ID: <20260318155554.1133405-1-toke@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iwgEUoxSGgZsYVpkolDJKKwcC24ZK7dvSkcUyCwJ_2s_1773849494
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch cited in the Fixes tag below changed the teardown code for
OVS ports to no longer unconditionally take the RTNL. After this change,
the netdev_destroy() callback can proceed immediately to the call_rcu()
invocation if the IFF_OVS_DATAPATH flag is already cleared on the
netdev.

The ovs_netdev_detach_dev() function clears the flag before completing
the unregistration, and if it gets preempted after clearing the flag (as
can happen on an -rt kernel), netdev_destroy() can complete and the
device can be freed before the unregistration completes. This leads to a
splat like:

[  998.393867] Oops: general protection fault, probably for non-canonical address 0xff00000001000239: 0000 [#1] SMP PTI
[  998.393877] CPU: 42 UID: 0 PID: 55177 Comm: ip Kdump: loaded Not tainted 6.12.0-211.1.1.el10_2.x86_64+rt #1 PREEMPT_RT
[  998.393886] Hardware name: Dell Inc. PowerEdge R740/0JMK61, BIOS 2.24.0 03/27/2025
[  998.393889] RIP: 0010:dev_set_promiscuity+0x8d/0xa0
[  998.393901] Code: 00 00 75 d8 48 8b 53 08 48 83 ba b0 02 00 00 00 75 ca 48 83 c4 08 5b c3 cc cc cc cc 48 83 bf 48 09 00 00 00 75 91 48 8b 47 08 <48> 83 b8 b0 02 00 00 00 74 97 eb 81 0f 1f 80 00 00 00 00 90 90 90
[  998.393906] RSP: 0018:ffffce5864a5f6a0 EFLAGS: 00010246
[  998.393912] RAX: ff00000000ffff89 RBX: ffff894d0adf5a05 RCX: 0000000000000000
[  998.393917] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffff894d0adf5a05
[  998.393921] RBP: ffff894d19252000 R08: ffff894d19252000 R09: 0000000000000000
[  998.393924] R10: ffff894d19252000 R11: ffff894d192521b8 R12: 0000000000000006
[  998.393927] R13: ffffce5864a5f738 R14: 00000000ffffffe2 R15: 0000000000000000
[  998.393931] FS:  00007fad61971800(0000) GS:ffff894cc0140000(0000) knlGS:0000000000000000
[  998.393936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  998.393940] CR2: 000055df0a2a6e40 CR3: 000000011c7fe003 CR4: 00000000007726f0
[  998.393944] PKRU: 55555554
[  998.393946] Call Trace:
[  998.393949]  <TASK>
[  998.393952]  ? show_trace_log_lvl+0x1b0/0x2f0
[  998.393961]  ? show_trace_log_lvl+0x1b0/0x2f0
[  998.393975]  ? dp_device_event+0x41/0x80 [openvswitch]
[  998.394009]  ? __die_body.cold+0x8/0x12
[  998.394016]  ? die_addr+0x3c/0x60
[  998.394027]  ? exc_general_protection+0x16d/0x390
[  998.394042]  ? asm_exc_general_protection+0x26/0x30
[  998.394058]  ? dev_set_promiscuity+0x8d/0xa0
[  998.394066]  ? ovs_netdev_detach_dev+0x3a/0x80 [openvswitch]
[  998.394092]  dp_device_event+0x41/0x80 [openvswitch]
[  998.394102]  notifier_call_chain+0x5a/0xd0
[  998.394106]  unregister_netdevice_many_notify+0x51b/0xa60
[  998.394110]  rtnl_dellink+0x169/0x3e0
[  998.394121]  ? rt_mutex_slowlock.constprop.0+0x95/0xd0
[  998.394125]  rtnetlink_rcv_msg+0x142/0x3f0
[  998.394128]  ? avc_has_perm_noaudit+0x69/0xf0
[  998.394130]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  998.394132]  netlink_rcv_skb+0x50/0x100
[  998.394138]  netlink_unicast+0x292/0x3f0
[  998.394141]  netlink_sendmsg+0x21b/0x470
[  998.394145]  ____sys_sendmsg+0x39d/0x3d0
[  998.394149]  ___sys_sendmsg+0x9a/0xe0
[  998.394156]  __sys_sendmsg+0x7a/0xd0
[  998.394160]  do_syscall_64+0x7f/0x170
[  998.394162]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  998.394165] RIP: 0033:0x7fad61bf4724
[  998.394188] Code: 89 02 b8 ff ff ff ff eb bb 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 80 3d c5 e9 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89
[  998.394189] RSP: 002b:00007ffd7e2f7cb8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  998.394191] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fad61bf4724
[  998.394193] RDX: 0000000000000000 RSI: 00007ffd7e2f7d20 RDI: 0000000000000003
[  998.394194] RBP: 00007ffd7e2f7d90 R08: 0000000000000010 R09: 000000000000003f
[  998.394195] R10: 000055df11558010 R11: 0000000000000202 R12: 00007ffd7e2f8380
[  998.394196] R13: 0000000069b233d7 R14: 000055df0a256040 R15: 0000000000000000
[  998.394200]  </TASK>

To fix this, reorder the operations in ovs_netdev_detach_dev() to only
clear the flag after completing the other operations, and introduce an
smp_wmb() to make the ordering requirement explicit. The smp_wmb() is
paired with a full smp_mb() in netdev_destroy() to make sure the
call_rcu() invocation does not happen before the unregister operations
are visible.

Reported-by: Minxi Hou <mhou@redhat.com>
Tested-by: Minxi Hou <mhou@redhat.com>
Fixes: 549822767630 ("net: openvswitch: Avoid needlessly taking the RTNL on vport destroy")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/openvswitch/vport-netdev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 6574f9bcdc02..c688dee96503 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -151,11 +151,15 @@ static void vport_netdev_free(struct rcu_head *rcu)
 void ovs_netdev_detach_dev(struct vport *vport)
 {
 	ASSERT_RTNL();
-	vport->dev->priv_flags &= ~IFF_OVS_DATAPATH;
 	netdev_rx_handler_unregister(vport->dev);
 	netdev_upper_dev_unlink(vport->dev,
 				netdev_master_upper_dev_get(vport->dev));
 	dev_set_promiscuity(vport->dev, -1);
+
+	/* paired with smp_mb() in netdev_destroy() */
+	smp_wmb();
+
+	vport->dev->priv_flags &= ~IFF_OVS_DATAPATH;
 }
 
 static void netdev_destroy(struct vport *vport)
@@ -174,6 +178,9 @@ static void netdev_destroy(struct vport *vport)
 		rtnl_unlock();
 	}
 
+	/* paired with smp_wmb() in ovs_netdev_detach_dev() */
+	smp_mb();
+
 	call_rcu(&vport->rcu, vport_netdev_free);
 }
 
-- 
2.53.0

