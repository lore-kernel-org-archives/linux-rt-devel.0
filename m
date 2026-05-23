Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C362330D34
	for <linux-rt-devel@lists.linux.dev>; Sat, 23 May 2026 02:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779503684; cv=none; b=nzl73+Pjh25Bf23skuQBgv97HCh5RpWPmAnRRVDmTeOQTuvpX1PFovBL2yOyoDllKq3T3clNo7cnRN6+dftmZEGk/alm4bg/rvI8j7jAvw0/yg5DaxTio+tEyC2rQ3R47abASRmzPyBNbXgoRU/sWjd85PiH1VqFAbnjBGmRqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779503684; c=relaxed/simple;
	bh=w62EixdXxW4lxN7YjkeQjbgrtjS8Wu59Jj7E2YpYpSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVLdokk9tkbPGuzTZbt3lKXeyeHX5Wgx2Z7ulSFPz77QF1YOjNJq7zuLEvdUx/wsrM3n2gvYxSczQcmzsgkD7Hvb3SUAhhqC8bjSGoqfwB6xHZA9uUg+JjWcrNFcBTFdAebTxp/6g5WlkJRClGNT8O6AV8E3UB/Yn1f54QwXSqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb+RW6Vz; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb+RW6Vz"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so106524656d6.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 22 May 2026 19:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779503682; x=1780108482; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sK2eCVykGOBgCXXqQhMEZuidmUMZ94iDMgqX9P1DHWY=;
        b=nb+RW6VzUPC+AlEMYey9XeFY+pCKNDZigLpya5zuPtrN1yhueyaxPBEEDa6CKBQKHb
         hKmR6bFmWVEtcHcT6txfbTv1M8nKMhLQV1hCRN9ivYeqBzEpISmw+/wy/19KHdMnXBSt
         crIe+ldw+NAtT32xsQMb9at9lVLhudL+XoPZwIBxReX+sInhdTj4soortrXLB95Hzhw6
         0Ur8rclFkJNDkk8AMada3PeaysIsKFEUAiHhPUglvhcRbtSk8riYVDjKmyNh9DL7DjI8
         dfZ2T5bfB0g7nZ+KrUkcAxBGY3ghW9k6zdnurg1UaWI11QxandwS/83CgDCDhmjdqDf9
         h11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779503682; x=1780108482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK2eCVykGOBgCXXqQhMEZuidmUMZ94iDMgqX9P1DHWY=;
        b=oW6bu3dXgVTSfGcdJI3hkSygRTwBNz032qcRL5zYhmVpqcj5zw1oEteAmrTr+2dbku
         zoUA9ai3DBCoUD+d419U/MkC/H6FCiF/pvU8vHphgpOYeLWGfcWPuiSry9azLlbpskJ/
         gl00+tIafxgRRJcXXCFQtSLfME131tcmTGR4kSuZ6i4H/43f08OZjNAVi04PsHg7YHTZ
         y7IRob1x8quXigQuIM0e6hJepJQpTYXBqkRXmWA0syvkRAk+x325RC4+aOghIbu1utCg
         CqAdHherDopNM5+BQPgT0+XoRE2VY72HvUoJ4OO95OoO7XSH79DJHj4OrKo9cLcTqlLU
         QJ2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Bco4rFSxb93qNbbXRipJlMIeYFqMIxg6MG7WsIxVvkYOIh7PXvppnC6+up/S49IF+nNTjNWgutCmeol/ZMA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywgj7LnlGwrZGeVHp3E/MNCmtFAidKwHzTxfIHIj+p4ChUhpnhj
	EoqEuKEGl4jBMt4rS1P5XcHLVlA+0MZNDdhkWDFcVOLyxVDALJfqaV0V
X-Gm-Gg: Acq92OHn0zEe792BnqAJEUeCm//RXDq5dJnZPjQT6xaECwtU806w1OSCvQQZ7JYOYkE
	hmqWrLcrTJxoXwDZmHG4Txv+4oS93hmU8CPclaxz4gQWuoy7QEItGAB4UR/Z+V4REia7oz0xDZP
	xn+7ZJW5rk/pqouYmD+uciLbRBDP+RkBm9wQtCvAX9LHhrdP2yhc4cucr9x/LNOfN3auQ31P8m7
	iaS6bpLFptRjVSLnwp7uiFhQVIwyRx4Y1+UsCE2/mxiwQEyt8eANObg9POeewHgiJGFtfIeOmD3
	VT6jGML1oak1IBf+cqJpQ4WKAgywnRVkJPmjfRHYiK6M5ogrukVcfYGaebq4X8hu3ayMwxRBPsJ
	fHW8iFMij0L6Gd6hCOzMnmBYceaRoj77kUlBqeKXe2jDqiiC15mhJFCbik+faVv8VaF+68nu5/b
	I/7LrnBz36DkZhGZb85pxYdMwKiBbH1PEMLX4TUyrfCNpw88QcjkWBC5rRxKwCDLCERkF/UzUrH
	jRcgSCCbWwKA4uJr2h2
X-Received: by 2002:a05:6214:5b85:b0:8ac:b677:c408 with SMTP id 6a1803df08f44-8cc7b5ebbfamr110690436d6.44.1779503682214;
        Fri, 22 May 2026 19:34:42 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e269csm35095256d6.25.2026.05.22.19.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 19:34:41 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] l2tp: use refcount_inc_not_zero in l2tp_session_get_by_ifname
Date: Fri, 22 May 2026 22:34:23 -0400
Message-ID: <20260523023423.2568972-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

A reader in l2tp_session_get_by_ifname() can return a pointer to a
session whose refcount has reached zero. The getter takes its
reference with plain refcount_inc(), but every other session getter
in the same file (l2tp_v2_session_get, l2tp_v3_session_get, and the
corresponding _get_next variants) uses refcount_inc_not_zero()
because the IDR/RCU lookup can race with refcount_dec_and_test() ->
l2tp_session_free() -> kfree_rcu(). The ifname getter is the only
outlier; the inconsistency was raised on-list after 979c017803c4
("l2tp: use list_del_rcu in l2tp_session_unhash").

A reader inside rcu_read_lock_bh() that matches session->ifname can
be preempted between the strcmp() and the refcount_inc(). If the
last reference drops on another CPU in that window, the reader's
refcount_inc() runs on a counter that has reached zero. refcount_t
catches the addition-on-zero, prints "refcount_t: addition on 0;
use-after-free", saturates the counter, and returns the saturated
pointer to the caller. Session memory is held live by the in-flight
RCU read section, but the kfree_rcu() callback queued from
l2tp_session_free() will free it once the grace period closes; a
caller that dereferences the returned session past that point hits
a slab-use-after-free. On PREEMPT_RT local_bh_disable() is a per-CPU
sleeping lock and the preemption window is real; on stock PREEMPT
kernels local_bh_disable() is a preempt_count increment that closes
the cross-CPU race in practice (see below).

Use refcount_inc_not_zero() and continue the list walk on failure,
matching the other session getters in the file. The ifname getter
is the only session getter in net/l2tp/ that still uses the bare
refcount_inc() pattern; this change restores file-internal
consistency. The success path is unchanged.

Fixes: abe7a1a7d0b6 ("l2tp: improve tunnel/session refcount helpers")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Distro reachability:

l2tp_core and l2tp_netlink autoload via the genl family alias
net-pf-16-proto-16-family-l2tp on first AF_NETLINK CTRL_CMD_GETFAMILY
lookup; pppol2tp autoloads on demand via net-l2tp-type-7 from
L2TP_CMD_SESSION_CREATE with pw_type=L2TP_PWTYPE_PPP. Neither
autoload requires CAP_SYS_MODULE. SESSION_GET / SESSION_CREATE /
SESSION_DELETE are GENL_UNS_ADMIN_PERM, so CAP_NET_ADMIN in the
netns user namespace suffices and is reachable from `unshare -Urn`
on Debian 11/12, Ubuntu 22.04 LTS / 23.10+ / 24.04+, Arch, Alpine;
RHEL/Fedora blacklist l2tp_netlink by default but on hosts running
NetworkManager-l2tp, xl2tpd, or any L2TPv3 endpoint the gate is open
there too. PREEMPT_RT ships on Ubuntu Pro Realtime, RHEL 9 RT, SUSE
RT, and Yocto-RT.

Reproduced on x86_64 QEMU/KVM. Under tracefs-kprobe widening at the
refcount-inc instruction, a PREEMPT_RT build hits "refcount_t:
addition on 0; use-after-free" through l2tp_session_get_by_ifname at
533 s; patched runs 1800 s clean. A stock PREEMPT (non-RT) build
with the same widening ran 1800 s without firing: local_bh_disable()
on non-RT prevents preemption inside the RCU section so the
cross-CPU window does not open at observable rates.

 net/l2tp/l2tp_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 1455f67e01ddb..0000000000000 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -441,12 +441,13 @@ struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
 		if (tunnel) {
 			list_for_each_entry_rcu(session, &tunnel->session_list, list) {
-				if (!strcmp(session->ifname, ifname)) {
-					refcount_inc(&session->ref_count);
-					rcu_read_unlock_bh();
+				if (strcmp(session->ifname, ifname))
+					continue;
+				if (!refcount_inc_not_zero(&session->ref_count))
+					continue;
+				rcu_read_unlock_bh();

-					return session;
-				}
+				return session;
 			}
 		}
 	}
--
2.46.0
