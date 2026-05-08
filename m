Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C53EDAC5;
	Fri,  8 May 2026 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247015; cv=none; b=jOyHR4/eq9SaFXAZjgowZZne9yBZix6puMB5irX4lhBzEwqwBdfcRjjPh3WF6wJ9VUyIsaDEXmepCdu2wAT8BqQNZSSyxrZb8DivXdPbepM6F/6EljWtxqBbposLByt1Qw5CaKKdXiEy8rIDbL1hdeyhWM3aQbugIMXk+e+y7vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247015; c=relaxed/simple;
	bh=Xbj/pnMzUb5x/z6kxsDEmCXpVFXkthdSDEyl0CENJ9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIivgPK2RSR9oZZfzFwf1/a4u+18fa8+YUm/eVhUjASrrkaGMpBdiCZyfmSYOkYo0hP6ObV0302A8xXiepDtxM6XCKm8QkzuDx0npq2nrxsmCpPBy8VhXt4ZT1mH68/J0jsHkZvjgxjNHi7L8t1OKducPD3vUJurd3qgC929vj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jkIU1Kgx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jkIU1Kgx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=T1Gk+dukeWGSlvBnhpJO7HvMhgIx2N3vM3eGZ0zDWKM=; b=jkIU1KgxFtWShqpAr9RQmjE3iT
	FNgA/UN+DpyWBpdta3ljzTvoPUiDHn7yzN4w5JZI5DusQtmKLmV9LXxo22yj342zkorqYOtLILYcH
	3Tb2EjnTeVUtl3nkWLt8qNb5E6RtXp7P8Uq5pMGf+yE+iD3axxRtY3O4fRRmJIxaSkJjnqDD2pial
	oX//T4rFajPqCQrIOmLTzImnk1mnDOxmTlaBp/0NqR9+UiY46AUutzHJyS2v1E7DkhLQSiOHGCk02
	yDxYlhJ/HOKThQGsis+3BmcXFVMvG+Z9X1FuL8lmaBoLt6OJ2UxUbSD4ciMC7SL0qki1flMQYmHE2
	dN5uViHQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLLHJ-005B06-0Y;
	Fri, 08 May 2026 13:30:05 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 08 May 2026 06:29:21 -0700
Subject: [PATCH net-next 7/8] netconsole: move netpoll_udp_checksum() from
 netpoll
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-netconsole_split-v1-7-0f660e62841f@debian.org>
References: <20260508-netconsole_split-v1-0-0f660e62841f@debian.org>
In-Reply-To: <20260508-netconsole_split-v1-0-0f660e62841f@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=3949; i=leitao@debian.org;
 h=from:subject:message-id; bh=Xbj/pnMzUb5x/z6kxsDEmCXpVFXkthdSDEyl0CENJ9A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/eU4M/8qiLCeRK3xfVVwvwbxAQu/cxVJCfajI
 rTGzFdrcdyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaf3lOAAKCRA1o5Of/Hh3
 bRJbD/9AuUKfArF1nM8WTMXlAh4V/srcQhp39H+41at0aXtJRdylz5ogAwHze4CblW47auwPyP6
 KlLiRfnAnVG2vIiw97lW3FsDoxBR+HSwJD8bqd4i6Aj/PyYTFZkRqdnUBLu5RX1YPayTX5R0m63
 zg7ZTEwHM+GHh++wCj446tPK4CJTi0J0BqaoebHxQA1Vn3inDqUw9nLze7/kDq/w/9UVZWOR1W2
 aliUNhfbDqdGmM4T2YYRmGWcuTYv7KljJIIAyCBtsoSkdACfUrhlru/0QvNeeR67eRKtNjSA76L
 XqbQhlITeK5E8uaBK7Rn1NrNgQtVnPi7csCBPxm8FbGi14hypVNk+SL0zV+2ydHQI4SZ/E1BIUG
 UlFLICPHi3x2ISQyt4SqJ6uGYPfg7nQQipikJWteeAD8lggA7jCEFUKLOWcooZjKo4LEhugUsPA
 g3FEsE95l1ri2SeSRj4ybuVssm3rTwEjdeA1dWbOslScBqC1+gWIZ5HNlwgJwANXkkpRF8qjLO2
 dJLqlnihgISfEsco0XGekALHuWTr4nZHclOxPbl86nKaYBhK7ktm8LgOweXEePlnw1rBq+i2eqJ
 +X466qwQnuY44acIBE+nUrJQvuhW05g8jx9KPkPkET7F7p+ZuOhM7UXgzO4lHBF8KFjq8G+93B/
 Z55nFB+415oVpRQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

netpoll_udp_checksum() computes the UDP checksum for netconsole's
packets. Move it into drivers/net/netconsole.c as a file-static
helper; drop its EXPORT_SYMBOL_GPL and remove the prototype from
include/linux/netpoll.h.

This was the last csum_ipv6_magic() consumer in
net/core/netpoll.c, so drop the now-stale <net/ip6_checksum.h>
include there. Pull it into netconsole.c so the moved code keeps
building.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 26 ++++++++++++++++++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 27 ---------------------------
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e8d96e482fe05..48d2670bbdef5 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -38,6 +38,7 @@
 #include <linux/netpoll.h>
 #include <linux/inet.h>
 #include <linux/unaligned.h>
+#include <net/ip6_checksum.h>
 #include <linux/configfs.h>
 #include <linux/etherdevice.h>
 #include <linux/hex.h>
@@ -1652,6 +1653,31 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
+				 int len)
+{
+	struct udphdr *udph;
+	int udp_len;
+
+	udp_len = len + sizeof(struct udphdr);
+	udph = udp_hdr(skb);
+
+	/* check needs to be set, since it will be consumed in csum_partial */
+	udph->check = 0;
+	if (np->ipv6)
+		udph->check = csum_ipv6_magic(&np->local_ip.in6,
+					      &np->remote_ip.in6,
+					      udp_len, IPPROTO_UDP,
+					      csum_partial(udph, udp_len, 0));
+	else
+		udph->check = csum_tcpudp_magic(np->local_ip.ip,
+						np->remote_ip.ip,
+						udp_len, IPPROTO_UDP,
+						csum_partial(udph, udp_len, 0));
+	if (udph->check == 0)
+		udph->check = CSUM_MANGLED_0;
+}
+
 static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	struct udphdr *udph;
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 03a49953a3d8a..1877d42ccbccf 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -74,7 +74,6 @@ void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
-void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb, int len);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 4ec9e309dfe6c..c148b3b68cec9 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -33,7 +33,6 @@
 #include <net/tcp.h>
 #include <net/addrconf.h>
 #include <net/ndisc.h>
-#include <net/ip6_checksum.h>
 #include <trace/events/napi.h>
 #include <linux/kconfig.h>
 
@@ -369,32 +368,6 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	return ret;
 }
 
-void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
-			  int len)
-{
-	struct udphdr *udph;
-	int udp_len;
-
-	udp_len = len + sizeof(struct udphdr);
-	udph = udp_hdr(skb);
-
-	/* check needs to be set, since it will be consumed in csum_partial */
-	udph->check = 0;
-	if (np->ipv6)
-		udph->check = csum_ipv6_magic(&np->local_ip.in6,
-					      &np->remote_ip.in6,
-					      udp_len, IPPROTO_UDP,
-					      csum_partial(udph, udp_len, 0));
-	else
-		udph->check = csum_tcpudp_magic(np->local_ip.ip,
-						np->remote_ip.ip,
-						udp_len, IPPROTO_UDP,
-						csum_partial(udph, udp_len, 0));
-	if (udph->check == 0)
-		udph->check = CSUM_MANGLED_0;
-}
-EXPORT_SYMBOL_GPL(netpoll_udp_checksum);
-
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	unsigned long flags;

-- 
2.53.0-Meta

