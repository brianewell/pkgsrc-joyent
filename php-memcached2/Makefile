# $NetBSD$
#

MODNAME=		memcached
PECL_VERSION=		2.0.0b2
CATEGORIES+=		devel

MAINTAINER=		filip@joyent.com
HOMEPAGE=		http://github.com/andreiz/php-memcached
COMMENT=		PHP extension for interfacing with memcached via libmemcached library
LICENSE=	php

PKG_DESTDIR_SUPPORT=	user-destdir

CONFLICTS=		php-memcached-[0-9]*

CONFIGURE_ARGS+=	--enable-${MODNAME}
CONFIGURE_ARGS+=	--with-libmemcached-dir=${PREFIX}
WRKSRC=			${WRKDIR}/${MODNAME}-${PECL_VERSION}

.include "../../wip/libmemcached/buildlink3.mk"
.include "../../lang/php/ext.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
